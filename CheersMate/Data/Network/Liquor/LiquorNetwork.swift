//
//  LiquorNetwork.swift
//  CheersMate
//
//  Created by 재훈 on 11/20/24.
//

import Foundation
import RxSwift

// 주류 API 명세서
public protocol LiquorNetworkProtocol {
    // 카테고리 별 주류 데이터 조회
    func fetchLiquorListByCategory(category: ProductType, page: Int) -> Single<LiquorsResponse>
    // 주류 데이터 상세 조회
    func fetchLiquorDetailsById(liquorId: Int) -> Single<LiquorsResponse>
} // closed UserNetworkProtocol

// 주류 네트워크
final public class LiquorNetwork: LiquorNetworkProtocol {
    // 주류 네트워크 매니저
    private let manager: LiquorNetworkManagerProtocol
    // init
    public init(manager: LiquorNetworkManagerProtocol) {
        self.manager = manager
    }
    // 네트워크 매니저로 카테고리 별 주류 데이터 조회 호출
    public func fetchLiquorListByCategory(category: ProductType, page: Int) -> Single<LiquorsResponse> {
        return manager.fetchLiquorListByCategory(category: category, page: page)
    }
    // 네트워크 매니저로 주류 데이터 상세 조회 호출
    public func fetchLiquorDetailsById(liquorId: Int) -> Single<LiquorsResponse> {
        return manager.fetchLiquorDetailsById(liquorId: liquorId)
    }
    
} // closed LiquorNetwork

