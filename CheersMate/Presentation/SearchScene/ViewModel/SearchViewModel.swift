//
//  DetailViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/12/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol SearchViewModelProtocol {
    func transform(input: SearchViewModel.Input) -> SearchViewModel.Output
}

public final class SearchViewModel: SearchViewModelProtocol {
    // 프로퍼티
    private let useCase: SearchUseCaseProtocol // 유스케이스
    private let productListRelay = BehaviorRelay<[Liquors]>(value: []) // VC로 아이템을 전달하는 릴레이
    private let dismissRelay = PublishRelay<Void>() // 화면의 dismiss를 전달하기 위한 릴레이
    private let errorRelay = PublishRelay<Error>() // 에러릴레이
    private let scrollToTopRelay = BehaviorRelay<Bool>(value: false)
    private var storedLiquors: [Liquors] = [] // 현재 페이지까지 저장된 아이템
    private let itemsPerPage = 20 // 페이지 당 아이템 수 20개
    private var currentPage = 0 // 현재 페이지
    private var currentKeyword = "" // 현재 검색어
    private let disposeBag: DisposeBag = DisposeBag()

    // init
    public init(useCase: SearchUseCaseProtocol) {
        self.useCase = useCase
    }
    
    // Input
    public struct Input {
        let cancelButtonTapped: Observable<Void> // 취소 버튼 클릭 이벤트
        let viewWillDisapper: Observable<Void> // viewWillDisapper 이벤트
        let searchButtonTapped: Observable<String> // 검색하기 버튼 클릭 이벤트
        let prefetchItems: Observable<[IndexPath]> // 컬렉션 뷰의 IndexPath 이벤트
    }
    
    // Output
    public struct Output {
        let dismissTrigger: Observable<Void>
        let productList: BehaviorRelay<[Liquors]>
        let scrollToTopTrigger: BehaviorRelay<Bool>
    }
    
    // transform
    public func transform(input: Input) -> Output {
        // 취소 버튼이 클릭됬을 때 이벤트
        input.cancelButtonTapped.subscribe(onNext: { [weak self] _ in
            self?.resetProperty()
            self?.productListRelay.accept([]) // 빈 배열 방출
            self?.dismissRelay.accept(()) // dismiss 이벤트 VC로 방출
        })
        .disposed(by: disposeBag)
        
        // viewWillDisapper 이벤트
        input.viewWillDisapper
            .subscribe(onNext: { [weak self] _ in
                print("viewWillDisapper")
            })
            .disposed(by: disposeBag)
        
        // 검색 버튼을 누를 때 검색어 이벤트
        input.searchButtonTapped
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] keyword in
                guard let self = self else { return }
                resetProperty()
                currentKeyword = keyword // 현재 키워드 갱신
                scrollToTopRelay.accept(true) // 스크롤 상단으로 이동
                fetchLiquorsByKeyword(keyword: currentKeyword, page: currentPage)
            })
            .disposed(by: disposeBag)
        
        
        // 컬렉션 뷰의 스크롤 indexPath 이벤트
        input.prefetchItems
            .subscribe(onNext: { [weak self] indexPath in
                print(indexPath)
                guard let self = self,
                      let lastIndexPath = indexPath.last else { return }
                if lastIndexPath.row > ((currentPage + 1) * self.itemsPerPage) - 4 { // 인덱스 값이 전체 아이템 개수 -4 이상일 경우
                    currentPage += 1
                    fetchLiquorsByKeyword(keyword: currentKeyword, page: currentPage)
                }
            })
            .disposed(by: disposeBag)
        
        
        return Output(dismissTrigger: dismissRelay.asObservable(), productList: productListRelay, scrollToTopTrigger: scrollToTopRelay)
    }
    
} // class ProductListViewModel

extension SearchViewModel {
    private func fetchLiquorsByKeyword(keyword: String, page: Int) {
        useCase.searchLiquors(keyword: keyword, page: page)
            .subscribe { [weak self] response in
                guard let self = self else { return }
                if response.result && response.httpCode == 200 {
                    storedLiquors += response.liquors.content // 기존 리스트에 새로운 리스트 추가
                    self.productListRelay.accept(storedLiquors) // 검색 상품 저장
                }
            } onFailure: { [weak self] error in
                self?.errorRelay.accept(error)
            }
            .disposed(by: disposeBag)
    }
    
    // 프로퍼티 초기화
    private func resetProperty() {
        storedLiquors = [] // 저장된 상품 초기화
        currentPage = 0 // 현재 페이지 초기화
        currentKeyword = "" // 현재 키워드 갱신
        scrollToTopRelay.accept(false) // 페이지 상단 이동 false 갱신
    }
                
} // closed extension
