//
//  LiquorRepositoryProtocol.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation
import RxSwift

// MARK: - Domain과 Data 영역의 의존성 역전을 위한 프로토콜(인터페이스)
public protocol LiquorRepositoryProtocol {
    // 주류 추천
    func requestRecommendationsForSelection(emotion: String, companion: String) -> Single<RecommendResponse>
    
} 
