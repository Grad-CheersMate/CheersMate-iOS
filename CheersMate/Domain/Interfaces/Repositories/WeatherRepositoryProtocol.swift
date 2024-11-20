//
//  WeatherRepositoryProtocol.swift
//  CheersMate
//
//  Created by 재훈 on 11/18/24.
//

// MARK: - Domain과 Data 영역의 의존성 역전을 위한 프로토콜(인터페이스)

import Foundation
import RxSwift

public protocol WeatherRepositoryProtocol {
    // 서버에 저장된 실시간 날씨 데이터 요청 API
    func fetchWeatherData() -> Single<WeatherResponse>
    // 오늘의 날씨와 현재 위치를 기반으로 주류를 추천받기 위한 데이터 요청 API
    func fetchLiquorRecommendation() -> Single<WeatherLiquorResponse>
}
