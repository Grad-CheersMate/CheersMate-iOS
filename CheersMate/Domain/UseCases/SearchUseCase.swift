//
//  SearchUseCase.swift
//  CheersMate
//
//  Created by 재훈 on 11/22/24.
//

// MARK: - 검색 화면에서 사용할 유스케이스 정의

import Foundation
import RxSwift

public protocol SearchUseCaseProtocol {
    // 사용자가 원하는 주류 상품을 검색할 때
    func searchLiquors(keyword: String, page: Int) -> Single<LiquorsResponse>
}

// 카테고리 유스케이스
public final class SearchUseCase: SearchUseCaseProtocol {
    // 리포지토리
    private let repository: LiquorRepositoryProtocol
    // init
    public init(repository: LiquorRepositoryProtocol) {
        self.repository = repository
    }
    
    // searchLiquors
    public func searchLiquors(keyword: String, page: Int) -> Single<LiquorsResponse> {
        return repository.searchLiquors(keyword: keyword, page: page)
    }

} // closed CategoryUseCase
