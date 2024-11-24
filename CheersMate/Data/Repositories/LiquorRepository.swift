//
//  LiquorRepository.swift
//  CheersMate
//
//  Created by 재훈 on 11/20/24.
//

// MARK: - Domain과 Data 영역을 연결해주는 Repository

import Foundation
import RxSwift

public class LiquorRepository: LiquorRepositoryProtocol {
    // 네트워크 객체
    private let network: LiquorNetworkProtocol
    
    // init
    public init(network: LiquorNetworkProtocol) {
        self.network = network
    }
    
    // 카테고리 별 주류 데이터 조회하기
    public func fetchLiquorListByCategory(category: ProductType, page: Int) -> Single<LiquorsResponse> {
        return network.fetchLiquorListByCategory(category: category, page: page)
    }
    
    // 주류 데이터 상세 조회하기
    public func fetchLiquorDetailsById(liquorId: Int) -> Single<LiquorsResponse> {
        return network.fetchLiquorDetailsById(liquorId: liquorId)
    }
    
    // 키워드로 주류 데이터 검색 호출하기
    public func searchLiquors(keyword: String, page: Int) -> Single<LiquorsResponse> {
        return network.searchLiquors(keyword: keyword, page: page)
    }
    
}
