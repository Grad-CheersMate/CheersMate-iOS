//
//  LiquorUseCase.swift
//  CheersMate
//
//  Created by 재훈 on 11/20/24.
//

// MARK: - 카테고리 화면에서 사용할 유스케이스 정의

import Foundation
import RxSwift

public protocol CategoryUseCaseProtocol {
    // 홈 화면에서 카테고리 중 한 가지를 클릭했을 때 카테고리 화면에 필요한 해당 카테고리의 모든 제품 리스트를 조회
    func fetchLiquorListByCategory(category: ProductType, page: Int) -> Single<LiquorsResponse>
    
    // 모든 제품 리스트가 있는 카테고리 화면에서 한 가지의 주류 아이템을 클릭했을 때 주류 상세 조회
    func fetchLiquorDetailsById(liquorId: Int) -> Single<LiquorsResponse>
    
    // 홈 화면에서 BEST 카테고리를 클릭했을 때
    func fetchBestLiquors() -> Single<BestResponse>
}


public final class CategoryUseCase: CategoryUseCaseProtocol {
    
    // 리포지토리
    private let repository: LiquorRepositoryProtocol
    
    // init
    public init(repository: LiquorRepositoryProtocol) {
        self.repository = repository
    }
    
    // fetchLiquorListByCategory
    public func fetchLiquorListByCategory(category: ProductType, page: Int) -> Single<LiquorsResponse> {
        return repository.fetchLiquorListByCategory(category: category, page: page)
    }
    
    // fetchLiquorDetailsById
    public func fetchLiquorDetailsById(liquorId: Int) -> Single<LiquorsResponse> {
        return repository.fetchLiquorDetailsById(liquorId: liquorId)
    }
    
    // fetchBestLiquors
    public func fetchBestLiquors() -> Single<BestResponse> {
        return repository.fetchBestLiquors()
    }
    
    
} // closed CategoryUseCase
