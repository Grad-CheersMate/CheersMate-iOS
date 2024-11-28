//
//  LiquorRepositoryProtocol.swift
//  CheersMate
//
//  Created by 재훈 on 11/20/24.
//

// MARK: - Domain과 Data 영역의 의존성 역전을 위한 프로토콜(인터페이스)

import Foundation
import RxSwift

public protocol LiquorRepositoryProtocol {
    // 카테고리 별 주류 데이터 조회 API
    func fetchLiquorListByCategory(category: ProductType, page: Int) -> Single<LiquorsResponse>
    // BEST(TOP 30) 주류 데이터 조회
    func fetchBestLiquors() -> Single<BestResponse>
    // 주류 데이터 상세 조회 API
    func fetchLiquorDetailsById(liquorId: Int) -> Single<LiquorsResponse>
    // 키워드로 주류 데이터 검색 API
    func searchLiquors(keyword: String, page: Int) -> Single<LiquorsResponse>
}
