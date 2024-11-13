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
    func requestRecommendationsForSelection(emotion: String, companion: String) -> Single<RecommendResponse>
    //func requestRecommendationsForSelection(emotion: String, companion: String, volume: String) -> Single<LiquorResponse>
} // closed UserNetworkProtocol

// MARK: - 주류 네트워크
final public class LiquorNetwork: LiquorNetworkProtocol {

    private let manager: LiquorNetworkManagerProtocol
    
    public init(manager: LiquorNetworkManagerProtocol) {
        self.manager = manager
    } // closed init
    
    // MARK: - 주류와 관련된 네트워크 요청
    // 주류 추천
    public func requestRecommendationsForSelection(emotion: String, companion: String) -> Single<RecommendResponse> {
        return manager.requestRecommendationsForSelection(emotion: emotion, companion: companion)
    } // closed requestRecommendationsForSelection
    
    
} // closed UserNetwork
