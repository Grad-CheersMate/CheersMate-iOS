//
//  LiquorNetwork.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation
import RxSwift

// MARK: - 주류 API 명세서
public protocol LiquorNetworkProtocol {
    // 주류 추천 API
    func requestRecommendationsForSelection(emotion: String, companion: String, preferredLiquor: String, preferredDegree: Int) -> Single<LiquorResponse>
    
} // closed UserNetworkProtocol

// MARK: - 주류 네트워크
final public class LiquorNetwork: LiquorNetworkProtocol {

    private let manager: LiquorNetworkManagerProtocol
    
    public init(manager: LiquorNetworkManagerProtocol) {
        self.manager = manager
    } // closed init
    
    // MARK: - 주류와 관련된 네트워크 요청
    // 주류 추천
    public func requestRecommendationsForSelection(emotion: String, companion: String, preferredLiquor: String, preferredDegree: Int) -> Single<LiquorResponse> {
        return manager.requestRecommendationsForSelection(emotion: emotion, companion: companion, preferredLiquor: preferredLiquor, preferredDegree: preferredDegree)
    } // closed requestRecommendationsForSelection
    
    
} // closed UserNetwork
