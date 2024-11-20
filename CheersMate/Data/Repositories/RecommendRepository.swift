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

    private let network: RecommendNetworkProtocol
    private let realm: RealmProtocol
    
    public init(network: RecommendNetworkProtocol, realm: RealmProtocol) {
        self.network = network
        self.realm = realm
    } // closed init
    
    // MARK: - 사용자의 선호를 종합하여 서버에 AI 추천 주류 및 안주 결과 요청
    public func requestRecommendationsForSelection(emotion: String, companion: String, volume: String) -> Single<RecommendResponse> {
        return network.requestRecommendationsForSelection(emotion: emotion, companion: companion, volume: volume)
    } // closed requestRecommendationsForSelection
    
    // MARK: - 사용자가 AI 주류 및 안주 추천 서비스를 사용하고 결과에 대한 평가를 서버에 제출
    public func submitRecommendationEvaluation(emotion: String, companion: String, liquor: Liquor, rating: Int) -> Single<RecommendResultResponse> {
        return network.submitRecommendationEvaluation(emotion: emotion, companion: companion, liquor: liquor, rating: rating)
    } // closed submitRecommendationEvaluation
    
    // MARK: - 추천 선택지(감정, 동반자, 도수) DB에서 가져오기
    public func readSelectionObject(type: PageType) -> [Selection] {
        return realm.readSelectionObject(type: type)
    } // closed readSelectionObject
    
    // MARK: - AI 추천 결과 DB에 저장하기
    public func saveRecommendResult(recommendData: RecommendData) -> Bool {
        return realm.saveRecommendResult(recommendData: recommendData)
    } // closed saveRecommendResult
    
    // MARK: - AI 추천 결과 DB에서 가져오기
    public func readRecommendResult() -> RecommendResult {
        return realm.readRecommendResult()
    } // closed readRecommendResult

} // closed SelectionRepository

