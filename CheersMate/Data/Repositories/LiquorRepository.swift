//
//  LiquorRepository.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation
import RxSwift

// MARK: - DB 또는 Network를 통해 Domain과 Data 영역을 연결해주는 Repository
// MARK: - DB는 Realm을 사용
public class LiquorRepository: LiquorRepositoryProtocol {
    
    private let network: LiquorNetworkProtocol
    
    public init(network: LiquorNetworkProtocol) {
        self.network = network
    } // closed init
    
    // 사용자가 AI 추천 주류 서비스를 이용할 때 네트워크 요청
    public func requestRecommendationsForSelection(emotion: String, companion: String, preferredLiquor: String, preferredDegree: Int) -> Single<LiquorResponse> {
        return network.requestRecommendationsForSelection(emotion: emotion, companion: companion, preferredLiquor: preferredLiquor, preferredDegree: preferredDegree)
    } // closed requestRecommendationsForSelection
    
} // closed LiquorRepository

