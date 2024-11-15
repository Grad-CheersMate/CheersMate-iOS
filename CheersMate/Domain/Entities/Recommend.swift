//
//  Recommend.swift
//  CheersMate
//
//  Created by 재훈 on 11/12/24.
//

// MARK: - 주류 및 안주 추천에서(/api/recommend) API요청의 응답

import Foundation

public struct RecommendResponse: Codable {
    let result: Bool
    let httpCode: Int
    let data: RecommendData
    let error: String?
}

public struct RecommendData: Codable {
    let request: RequestInfo
    let recommendLiquor: [LiquorResponse]
    let food: [Food]
    let similarLiquor: [LiquorResponse]
    
    enum CodingKeys: String, CodingKey {
        case request
        case recommendLiquor = "recommend"
        case food
        case similarLiquor = "similar"
    }
}

public struct RequestInfo: Codable {
    let weather: String
    let emotion: String
    let companion: String
}

// MARK: - AI 추천 결과 DB에서 가져올 때 사용할 구조체
public struct RecommendResult {
    let emotion: String
    let companion: String
    let recommendLiquor: Liquor
    let foods: [Food]
    let similarLiquors: [Liquor]
    
    public init(from object: RecommendObject) {
        self.emotion = object.emotion
        self.companion = object.companion
        self.recommendLiquor = object.recommendLiquor!.toLiquor()
        self.foods = object.foods.map{ $0.toFood() }
        self.similarLiquors = object.similarLiquors.map{ $0.toLiquor() }
    } // closed init
}

public struct RecommendResultResponse: Codable {
    let result: Bool
    let httpCode: Int
    let text: String
}
