//
//  SelectionUseCase.swift
//  CheersMate
//
//  Created by 재훈 on 11/10/24.
//

import Foundation
import RxSwift

public protocol RecommendUseCaseProtocol {
    // 주류 추천 API 호출하기
    func requestRecommendationsForSelection(emotion: String, companion: String, volume: String) -> Single<RecommendResponse>
    
    // AI 주류 및 안주 추천 서비스를 사용하고 결과에 대한 평가 API 호출하기
    func submitRecommendationEvaluation(emotion: String, companion: String, liquor: Liquor, rating: Int) -> Single<RecommendResultResponse>
    
    // 추천 선택지(감정, 동반자, 도수) DB에서 가져오기
    func readSelectionObject(type: PageType) -> [Selection]
    
    // AI 추천 결과 DB에 저장하기
    func saveRecommendResult(recommendData: RecommendData) -> Bool
    
    // AI 추천 결과 DB에서 가져오기
    func readRecommendResult() -> RecommendResult
    
}

public final class RecommendUseCase: RecommendUseCaseProtocol {

    private let repository: RecommendRepositoryProtocol
    
    // init
    public init(repository: RecommendRepositoryProtocol) {
        self.repository = repository
    }
    
    // AI 주류 추천 기능에서 사용자가 결과 확인 버튼을 클릭했을 때
    public func requestRecommendationsForSelection(emotion: String, companion: String, volume: String) -> Single<RecommendResponse> {
        return repository.requestRecommendationsForSelection(emotion: emotion, companion: companion, volume: volume)
    }
    
    // AI 주류 및 안주 추천 서비스를 사용하고 결과에 대한 평가 API 호출하기
    public func submitRecommendationEvaluation(emotion: String, companion: String, liquor: Liquor, rating: Int) -> Single<RecommendResultResponse> {
        return repository.submitRecommendationEvaluation(emotion: emotion, companion: companion, liquor: liquor, rating: rating)
    }
    
    // AI 주류 추천 기능에서 화면에 따라 DB에서 셀 데이터를 가져오기
    public func readSelectionObject(type: PageType) -> [Selection] {
        return repository.readSelectionObject(type: type)
    }
    
    // AI 주류 추천 기능에서 추천 결과를 DB에 저장하고 필요할 때 쓰기위해서
    public func saveRecommendResult(recommendData: RecommendData) -> Bool {
        return repository.saveRecommendResult(recommendData: recommendData)
    }
    
    public func readRecommendResult() -> RecommendResult {
        return repository.readRecommendResult()
    }
    
} // closed selectionUseCaseProtocol
