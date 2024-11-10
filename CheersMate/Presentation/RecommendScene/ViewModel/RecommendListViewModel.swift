//
//  RecommendViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/4/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol RecommendListViewModelProtocol {
    func transform(input: RecommendListViewModel.Input) -> RecommendListViewModel.Output
} // closed RecommendViewModelProtocol

public final class RecommendListViewModel: RecommendListViewModelProtocol {
    
    private let useCase: RecommendUseCaseProtocol
    private let pageNumRelay: BehaviorRelay<Int> = BehaviorRelay(value: 1) // 페이지 번호
    private let pageTypeRelay: BehaviorRelay<SelectionType> = BehaviorRelay(value: .emotion) // 페이지 타입
    // private let selectionList: BehaviorRelay<[SelectionObject]> = BehaviorRelay(value: <#T##Element#>)        // 선택 리스트
    private let disposeBag: DisposeBag = DisposeBag()
    
    public init(useCase: RecommendUseCaseProtocol) {
        self.useCase = useCase
    } // closed init
    
    public struct Input {
        let completeButtonTapped: ControlEvent<Void> // 확인 버튼 클릭 이벤트
    } // closed Input
    
    public struct Output {
        let pageNum: Signal<Int> // 페이지 번호
        let selections: Signal<[Selection]> // 페이지 타입
    } // closed Output
    
    public func transform(input: Input) -> Output {
        
        // 확인 버튼을 클릭 이벤트 처리
        input.completeButtonTapped
            .subscribe(onNext: { [weak self] _ in
                self?.switchPage()
            })
            .disposed(by: disposeBag)
        
        
        let selections = pageTypeRelay
            .map { [weak self] pageType -> [Selection] in
                guard let self = self else { return [] }
                return self.useCase.readSelectionObject(type: pageType)
            }
        
        return Output(pageNum: pageNumRelay.asSignal(onErrorJustReturn: 1), selections: selections.asSignal(onErrorJustReturn: []))
    } // closed transform
    
    
} // closed RecommendViewModel

// MARK: - Extension
extension RecommendListViewModel {
    
    // 페이지 번호 증가
    private func switchPage() {
        // 최대 페이지는 4페이지. 따라서 3으로 제한
        if pageNumRelay.value <= 3 {
            let newPage = pageNumRelay.value + 1
            pageNumRelay.accept(newPage)
            switchPageType(pageNum: newPage)
        }
    } // closed incrementPage
    
    // 페이지 타입 교체
    private func switchPageType(pageNum: Int) {
        switch pageNum {
        case 1:
            return pageTypeRelay.accept(.emotion)
        case 2:
            return pageTypeRelay.accept(.companion)
        case 3:
            return pageTypeRelay.accept(.liquorType)
        case 4:
            return pageTypeRelay.accept(.liquorLevel)
        default:
            break
        }
    } // closed switchPageType
    
    
} // extension
