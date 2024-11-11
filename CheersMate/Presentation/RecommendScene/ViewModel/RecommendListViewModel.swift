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
public protocol RecommendListViewModelProtocol {
    func transform(input: RecommendListViewModel.Input) -> RecommendListViewModel.Output
} // closed RecommendViewModelProtocol

public final class RecommendListViewModel: RecommendListViewModelProtocol {
    private let useCase: RecommendUseCaseProtocol // 유스케이스
    private var selectedIndexPath: IndexPath? // 클릭된 셀의 IndexPath 정보
    private let buttonEnabledRelay = PublishRelay<Bool>() // 다음 버튼의 활성화 여부
    private let updatedIndexPathRelay = PublishRelay<(previous: IndexPath?, current: IndexPath?, isDeselected: Bool)>()
    private let selectionTypeRelay = BehaviorRelay<PageType>(value: .emotion) // 페이지 타입
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
        let selectionType: BehaviorRelay<PageType> // 페이지 번호
        let selections: Signal<[Selection]> // 페이지 타입
    } // closed Output
    
    // MARK: - transform을 통해 ViewController와 연결 설정
    public func transform(input: Input) -> Output {
        input.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                let previousIndexPath = self.selectedIndexPath
                let isDeselected = (previousIndexPath == indexPath) // 기존 셀과 현재 셀이 같을 경우에는 Deselected 체크가 필요
                
                if isDeselected { // 기존 셀 == 현재 셀
                    self.selectedIndexPath = nil // 선택된 셀 없음으로 체크
                    self.buttonEnabledRelay.accept(false) // 버튼 비활성화로 false 방출
                } else { // 기존 셀 != 현재 셀
                    self.selectedIndexPath = indexPath // 갱신
                    self.buttonEnabledRelay.accept(true) // 버튼 비활성화로 true 방출
                }
                self.updatedIndexPathRelay.accept((previous: previousIndexPath, current: indexPath, isDeselected: isDeselected))
            })
            .disposed(by: disposeBag)
        
        
        // 확인 버튼을 클릭 이벤트 처리
        input.completeButtonTapped
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.switchPageType(currentPageType: self.selectionTypeRelay.value)
            })
            .disposed(by: disposeBag)
        
        
        let selections = selectionTypeRelay
            .map { [weak self] pageType -> [Selection] in
                guard let self = self else { return [] }
                return self.useCase.readSelectionObject(type: pageType)
            }
        
        return Output(buttonEnable: buttonEnabledRelay.asObservable(),
                      updatedIndexPath: updatedIndexPathRelay.asObservable(),
                      selectionType: selectionTypeRelay,
                      selections: selections.asSignal(onErrorJustReturn: []))
    } // closed transform
    
} // closed RecommendViewModel

// MARK: - Extension
extension RecommendListViewModel {
    // 페이지 타입 교체
    private func switchPageType(currentPageType type: PageType) {
        switch type {
        case .emotion:
            return selectionTypeRelay.accept(.companion)
        case .companion:
            return selectionTypeRelay.accept(.liquorVolume)
        case .liquorVolume:
            return selectionTypeRelay.accept(.recommendResult)
        case .recommendResult:
            break
        }
    } // closed switchPageType
    
} // extension
