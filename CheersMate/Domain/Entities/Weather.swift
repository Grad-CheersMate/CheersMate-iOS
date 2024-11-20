//
//  Weather.swift
//  CheersMate
//
//  Created by 재훈 on 11/18/24.
//

import Foundation

// 서버에 저장된 실시간 날씨 데이터 요청에 대한 Json 응답 객체
public struct WeatherResponse: Codable {
    let result: Bool
    let httpCode: Int
    let weather: Weather
}
public struct Weather: Codable {
    let id: Int
    let date: String // 날짜
    let time: String // 최신 업데이트 시간
    let precipitationType: String // 강수량
    let humidity: String // 습도
    let hourlyPrecipitation: String // 시간 강수량
    let windDirection: String? // 풍향
    let windSpeed: String // 풍속
    let temperature: String // 기온
    let condition: String // 날씨 상태
    let vWindComponent: String? // v 성분 풍향
    let uWindComponent: String? // u 성분 풍향

    // CodingKeys enum으로 매핑 정의
    enum CodingKeys: String, CodingKey {
        case id = "weatherId"
        case date = "weatherDate"
        case time = "weatherTime"
        case precipitationType
        case humidity
        case hourlyPrecipitation
        case windDirection
        case windSpeed
        case temperature
        case condition = "weatherCondition"
        case vWindComponent = "vcomponentWind"
        case uWindComponent = "ucomponentWind"
    }
}

// 오늘의 날씨와 현재 위치를 기반으로 주류를 추천 요청에 대한 응답 객체
public struct WeatherLiquorResponse: Codable {
    let result: Bool
    let httpCode: Int
    let data: RecommendationData
    let error: String?
}
public struct RecommendationData: Codable {
    let request: RequestDetails
    let recommend: [LiquorRecommendation]
    let food: String?
    let similar: String?
}
public struct RequestDetails: Codable {
    let weather: String
    let emotion: String?
    let companion: String?
}
public struct LiquorRecommendation: Codable {
    let liquor: Liquor
}
