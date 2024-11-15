//
//  SelectionRepositoryProtocol.swift
//  CheersMate
//
//  Created by 재훈 on 11/10/24.
//

import Foundation
import RxSwift
import RealmSwift

public protocol RecommendRepositoryProtocol {
    // MARK: - AI 주류 및 안주 추천 서비스 API 호출하기
    func requestRecommendationsForSelection(emotion: String, companion: String) -> Single<RecommendResponse>
    // MARK: - AI 주류 및 안주 추천 서비스를 사용하고 결과에 대한 평가 API 호출하기
    func submitRecommendationEvaluation(emotion: String, companion: String, liquor: Liquor, rating: Int) -> Single<RecommendResultResponse>
    // MARK: - 추천 선택지(감정, 동반자, 도수) DB에서 가져오기
    func readSelectionObject(type: PageType) -> [Selection]
    // MARK: - AI 추천 결과를 DB에 저장하기
    func saveRecommendResult(recommendData: RecommendData) -> Bool
    // MARK: - AI 추천 결과를 DB에서 가져오기
    func readRecommendResult() -> RecommendResult
} // closed SelectionRepositoryProtocol
