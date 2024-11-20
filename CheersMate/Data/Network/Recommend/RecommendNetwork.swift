//
//  LiquorNetwork.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation
import RxSwift

// MARK: - 주류 API 명세서
public protocol RecommendNetworkProtocol {
    // MARK: - 사용자의 선호를 종합하여 서버에 AI 추천 주류 및 안주 결과 요청
    func requestRecommendationsForSelection(emotion: String, companion: String, volume: String) -> Single<RecommendResponse>
    // MARK: - 사용자가 AI 주류 및 안주 추천 서비스를 사용하고 결과에 대한 평가를 서버에 제출
    func submitRecommendationEvaluation(emotion: String, companion: String, liquor: Liquor, rating: Int) -> Single<RecommendResultResponse>
} // closed UserNetworkProtocol

// MARK: - 주류 네트워크
final public class RecommendNetwork: RecommendNetworkProtocol {

    private let manager: RecommendNetworkManagerProtocol
    
    public init(manager: RecommendNetworkManagerProtocol) {
        self.manager = manager
    } // closed init
    

    // MARK: - 사용자의 선호를 종합하여 서버에 AI 추천 주류 및 안주 결과 요청
    public func requestRecommendationsForSelection(emotion: String, companion: String, volume: String) -> Single<RecommendResponse> {
        return manager.requestRecommendationsForSelection(emotion: emotion, companion: companion, volume: volume)
    } // closed requestRecommendationsForSelection
    
    // MARK: - 사용자가 AI 주류 및 안주 추천 서비스를 사용하고 결과에 대한 평가를 서버에 제출
    public func submitRecommendationEvaluation(emotion: String, companion: String, liquor: Liquor, rating: Int) -> Single<RecommendResultResponse>{
        return manager.submitRecommendationEvaluation(emotion: emotion, companion: companion, liquor: liquor, rating: rating)
    } // closed submitRecommendationEvaluation
    
} // closed UserNetwork
