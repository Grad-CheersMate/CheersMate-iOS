//
//  RecommendViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/4/24.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - 프로토콜 설정
public protocol RecommendSelectionViewModelProtocol {
    func transform(input: RecommendSelectionViewModel.Input) -> RecommendSelectionViewModel.Output
} // closed RecommendViewModelProtocol

public final class RecommendSelectionViewModel: RecommendSelectionViewModelProtocol {
    private let useCase: RecommendUseCaseProtocol // 유스케이스
    private var selectedIndexPath: IndexPath? // 클릭된 셀의 IndexPath 정보
    private let buttonEnabledRelay = PublishRelay<Bool>() // 다음 버튼의 활성화 여부
    private let updatedIndexPathRelay = PublishRelay<(previous: IndexPath?, current: IndexPath?, isDeselected: Bool)>() // (이전인덱스, 현재인덱스, 일치여부)
    private let currnetPageTypeRelay = BehaviorRelay<PageType>(value: .emotion) // 현재 페이지 타입
    private let selectionsRelay = BehaviorRelay<[Selection]>(value: []) // 현재 페이지 타입
    private let recommendResponseRelay = PublishRelay<RecommendResponse>()
    private var titles: [String] = [] // 선택 결과들을 저장
    private let disposeBag = DisposeBag()
    
    // MARK: - UseCase 주입
    public init(useCase: RecommendUseCaseProtocol) {
        self.useCase = useCase
    } // closed init
    
    // MARK: - Input <-> Output 구조
    public struct Input {
        let itemSelected: Observable<IndexPath> // 테이블 뷰의 셀 클릭 이벤트
        let completeButtonTapped: ControlEvent<Void> // 확인 버튼 클릭 이벤트
    } // closed Input
    
    public struct Output {
        let buttonEnable: Observable<Bool> // 버튼의 활성화
        let updatedIndexPath: Observable<(previous: IndexPath?, current: IndexPath?, isDeselected: Bool)>
        let currentPageType: Observable<PageType> // 현재 페이지 타입
        let selections: Observable<[Selection]> // 페이지의 셀 데이터
        let recommendResponse: Observable<RecommendResponse>
    } // closed Output
    
    // MARK: - transform을 통해 ViewController와 연결 설정
    public func transform(input: Input) -> Output {
        // 페이지에 따라서 선택지를 DB에서 패치. 페이지도 교체되면 데이터도 패치필수
        currnetPageTypeRelay
            .subscribe(onNext: { [weak self] pageType in
                self?.fetchSelection(pageType: pageType)
            })
            .disposed(by: disposeBag)
        
        input.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let previousIndexPath = self.selectedIndexPath
                let isDeselected = (previousIndexPath == indexPath) // 기존 셀과 현재 셀이 같을 경우에는 Deselected 체크가 필요
                self.selectedIndexPath = isDeselected ? nil : indexPath // 기존 셀과 현재 셀이 같을 때는 선택 해제
                self.buttonEnabledRelay.accept(!isDeselected)
                self.updatedIndexPathRelay.accept((previous: previousIndexPath, current: indexPath, isDeselected: isDeselected))
            })
            .disposed(by: disposeBag)
        
        // 확인 버튼 클릭 시 페이지 변경 및 선택한 데이터 출력
        input.completeButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self = self, let indexPath = self.selectedIndexPath else { return }
                let title = self.selectionsRelay.value[indexPath.row].title // 사용자의 선택지에서 title만 추출
                self.titles.append(title) // 선택지의 title을 배열에 저장
                self.selectedIndexPath = nil
                let currentPageType = currnetPageTypeRelay.value
                switchPageType(currentPageType)
            })
            .disposed(by: disposeBag)
        
        return Output(buttonEnable: buttonEnabledRelay.asObservable(),
                      updatedIndexPath: updatedIndexPathRelay.asObservable(),
                      currentPageType: currnetPageTypeRelay.asObservable(),
                      selections: selectionsRelay.asObservable(),
                      recommendResponse: recommendResponseRelay.asObservable())
    } // closed transform
    
} // closed RecommendViewModel

// MARK: - Extension
extension RecommendSelectionViewModel {
    // 페이지 타입 교체하기
    private func switchPageType(_ pageType: PageType) {
        if pageType == .emotion {
            currnetPageTypeRelay.accept(.companion) // 감정 선택지에서 동반자 선택지로 변경
        } else if pageType == .companion {
            currnetPageTypeRelay.accept(.liquorVolume) // 동반자 선택지에서 도수 선택지로 변경
        } else if pageType == .liquorVolume {
            requestRecommendations()
        }
        
    } // closed switchPageType
    
    // 선택지 정보 가져오기
    private func fetchSelection(pageType: PageType) {
        let selections = useCase.readSelectionObject(type: pageType)
        selectionsRelay.accept(selections)
    } // closed fetchSelection
    
    // 서버에서 추천 결과 가져오기
    private func requestRecommendations() {
        guard titles.count >= 3 else { return }
        useCase.requestRecommendationsForSelection(emotion: titles[0], companion: titles[1])
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                if response.result && response.httpCode == 200 {
                    // 선택을 종합하여 최종 결과 DB에 저장
                    if self.useCase.saveRecommendResult(recommendData: response.data) {
                        self.recommendResponseRelay.accept(response)
                    }
                }
            })
            .disposed(by: disposeBag)
    } // closed requestRecommendations
    
    
} // extension
