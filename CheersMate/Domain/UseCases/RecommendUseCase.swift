//
//  SelectionUseCase.swift
//  CheersMate
//
//  Created by 재훈 on 11/10/24.
//

import Foundation
import RxSwift

public protocol RecommendUseCaseProtocol {
    // 주류 추천 API
    func requestRecommendationsForSelection(emotion: String, companion: String) -> Single<RecommendResponse>
    // DB에서 감정, 동반자, 선호 주종, 선호 도수 선택지를 가져오기
    func readSelectionObject(type: PageType) -> [Selection]
    
} // closed selectionUseCaseProtocol

public final class RecommendUseCase: RecommendUseCaseProtocol {
    
    private let repository: RecommendRepositoryProtocol
    
    public init(repository: RecommendRepositoryProtocol) {
        self.repository = repository
    } // closed init
    
    // AI 주류 추천 기능에서 사용자가 결과 확인 버튼을 클릭했을 때
    public func requestRecommendationsForSelection(emotion: String, companion: String) -> Single<RecommendResponse> {
        return repository.requestRecommendationsForSelection(emotion: emotion, companion: companion)
    } // closed requestRecommendationsForSelection
    
    // AI 주류 추천 기능에서 화면에 따라 DB에서 셀 데이터를 가져오기
    public func readSelectionObject(type: PageType) -> [Selection] {
        return repository.readSelectionObject(type: type)
    } // closed readSelectionObject
    
    
} // closed selectionUseCaseProtocol
