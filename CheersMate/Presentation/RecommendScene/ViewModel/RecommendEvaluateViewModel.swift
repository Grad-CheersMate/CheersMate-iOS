//
//  RecommendEvaluateViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/15/24.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - 프로토콜 설정
public protocol RecommendEvaluateViewModelProtocol {
    func transform(input: RecommendEvaluateViewModel.Input) -> RecommendEvaluateViewModel.Output
} // closed RecommendEvaluateViewModelProtocol

public final class RecommendEvaluateViewModel: RecommendEvaluateViewModelProtocol {
    private let useCase: RecommendUseCaseProtocol // 유스케이스
    private let messageRelay = PublishRelay<String>()
    private let ratingRelay = BehaviorRelay<Int>(value: 3) // 초기 별점 3점
    private let disposeBag = DisposeBag()
    
    // MARK: - UseCase 주입
    public init(useCase: RecommendUseCaseProtocol) {
        self.useCase = useCase
    } // closed init
    
    // MARK: - Input <-> Output 구조
    public struct Input {
        let cosmosInfoText: Observable<String?>
        let submitButtonTapped: Observable<Void> // 제출하기 버튼 클릭
    } // closed Input
    
    public struct Output {
        let presentingDismiss: Observable<String>
    } // closed Output
    
    // MARK: - transform을 통해 ViewController와 연결 설정
    public func transform(input: Input) -> Output {
        input.cosmosInfoText
            .subscribe(onNext: { [weak self] text in
                self?.convertTextToRating(text: text)
            })
            .disposed(by: disposeBag)
        
        // 사용자가 제출하기 버튼을 클릭했을 때
        input.submitButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let result = self.readRecommendResult()
                self.submitRecommendationEvaluation(recommendResult: result)
            })
            .disposed(by: disposeBag)
        
        return Output(presentingDismiss: messageRelay.asObservable())
    } // closed transform
    
} // closed RecommendEvaluateViewModel

// MARK: - Extension
extension RecommendEvaluateViewModel {
    // 가장 최신의 추천 결과 가져오기
    private func readRecommendResult() -> RecommendResult {
        return self.useCase.readRecommendResult()
    }
    
    // 서버로 평가 제출하기
    private func submitRecommendationEvaluation(recommendResult: RecommendResult) {
        useCase.submitRecommendationEvaluation(emotion: recommendResult.emotion, companion: recommendResult.companion, liquor: recommendResult.recommendLiquor, rating: ratingRelay.value)
            .subscribe { [weak self] res in
                if res.result && res.httpCode == 200 {
                    self?.messageRelay.accept(res.text)
                }
            } onFailure: { err in
                print(err)
            }
            .disposed(by: disposeBag)
    } // closed submitRecommendationEvaluation
    
    private func convertTextToRating(text: String?) {
        guard let text = text else { return }
        switch text {
        case "최고였어요 🥰":
            ratingRelay.accept(5)
        case "만족했어요 😊":
            ratingRelay.accept(4)
        case "보통이에요 😐":
            ratingRelay.accept(3)
        case "부족했어요 😕":
            ratingRelay.accept(2)
        case "아쉬웠어요 😞":
            ratingRelay.accept(1)
        default:
            break
        }
    }
} // extension
