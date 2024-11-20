//
//  ProductViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/19/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ProductListViewModelProtocol {
    func transform(input: ProductListViewModel.Input) -> ProductListViewModel.Output
}

public final class ProductListViewModel: ProductListViewModelProtocol {
    // 프로퍼티
    private let useCase: CategoryUseCaseProtocol
    private let type: ProductType // 보여줄 상품 타입
    private var page: Int = 0 // 페이지 정보
    private let listRelay = BehaviorRelay<[Liquors]>(value: [])
    private let errorRelay = PublishRelay<Error>()
    private let disposeBag: DisposeBag = DisposeBag()

    // init
    public init(useCase: CategoryUseCaseProtocol, productType: ProductType) {
        self.useCase = useCase
        self.type = productType
        fetchLiquorList(type: productType, page: 0)
    }
    // Input
    public struct Input {

    }
    // Output
    public struct Output {
        let items: Observable<[Liquors]>
    }
    // transform
    public func transform(input: Input) -> Output {
        
        return Output(items: listRelay.asObservable())
    }
    
} // class ProductListViewModel

extension ProductListViewModel {
    // 서버 DB에서 카테고리에 맞는 주류 리스트를 가져오기
    private func fetchLiquorList(type: ProductType, page: Int) {
        useCase.fetchLiquorListByCategory(category: type, page: page)
            .subscribe { [weak self] response in
                if response.result && response.httpCode == 200 {
                    self?.listRelay.accept(response.liquors.content)
                }
            } onFailure: { [weak self] error in
                self?.errorRelay.accept(error)
            }
            .disposed(by: disposeBag)
    }
}
