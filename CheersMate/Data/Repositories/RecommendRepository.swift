//
//  SelectionRepository.swift
//  CheersMate
//
//  Created by 재훈 on 11/10/24.
//

import Foundation
import RxSwift
import RealmSwift

// MARK: - DB 또는 Network를 통해 Domain과 Data 영역을 연결해주는 Repository
// MARK: - DB는 Realm을 사용
public final class RecommendRepository: RecommendRepositoryProtocol {
    
    private let network: LiquorNetworkProtocol
    private let realm: SelectionRealmProtocol
    
    public init(network: LiquorNetworkProtocol, realm: SelectionRealmProtocol) {
        self.network = network
        self.realm = realm
    } // closed init
    
    // 사용자가 주류 추천 서비스에서 선택지의 모든 단계를 수행한 후 서버에 결과를 전달하기 위한 네트워크 요청
    public func requestRecommendationsForSelection(emotion: String, companion: String) -> Single<RecommendResponse> {
        return network.requestRecommendationsForSelection(emotion: emotion, companion: companion)
    } // closed requestRecommendationsForSelection
    
    public func readSelectionObject(type: PageType) -> [Selection] {
        return realm.readSelectionObject(type: type)
    } // closed readSelectionObject
    
    
} // closed SelectionRepository

