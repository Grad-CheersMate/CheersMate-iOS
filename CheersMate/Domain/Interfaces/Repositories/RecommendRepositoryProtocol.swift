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
    // 주류 추천 API
    func requestRecommendationsForSelection(emotion: String, companion: String) -> Single<RecommendResponse>
    // DB에서 감정, 동반자, 선호 주종, 선호 도수 선택지를 가져오기
    func readSelectionObject(type: PageType) -> [Selection]
    
} // closed SelectionRepositoryProtocol
