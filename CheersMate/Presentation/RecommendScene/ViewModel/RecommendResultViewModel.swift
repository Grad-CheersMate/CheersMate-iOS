//
//  RecommendResultViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/14/24.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - 프로토콜 설정
public protocol RecommendResultViewModelProtocol {
    func transform(input: RecommendResultViewModel.Input) -> RecommendResultViewModel.Output
} // closed RecommendViewModelProtocol

public final class RecommendResultViewModel: RecommendResultViewModelProtocol {
    private let useCase: RecommendUseCaseProtocol // 유스케이스
    private let disposeBag = DisposeBag()
    
    // MARK: - UseCase 주입
    public init(useCase: RecommendUseCaseProtocol) {
        self.useCase = useCase
    } // closed init
    
    // MARK: - Input <-> Output 구조
    public struct Input {
        let dismissButtonTapped: Observable<Void> // 확인 버튼 클릭 이벤트
    } // closed Input
    
    public struct Output {

    } // closed Output
    
    // MARK: - transform을 통해 ViewController와 연결 설정
    public func transform(input: Input) -> Output {
      
        return Output()
    } // closed transform
    
} // closed RecommendViewModel

// MARK: - Extension
extension RecommendResultViewModel {

    
} // extension
