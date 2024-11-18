//
//  WeatherNetwork.swift
//  CheersMate
//
//  Created by 재훈 on 11/18/24.
//

import Foundation
import RxSwift

// 날씨 API 명세서
public protocol WeatherNetworkProtocol {
    // 서버에 저장된 실시간 날씨 데이터를 요청
    func fetchWeatherData() -> Single<WeatherResponse>
    // 오늘의 날씨와 현재 위치를 기반으로 주류를 추천받기 위한 데이터 요청
    func fetchLiquorRecommendation() -> Single<WeatherLiquorResponse>
} // closed UserNetworkProtocol

// 날씨 네트워크
final public class WeatherNetwork: WeatherNetworkProtocol {
    // 날씨 네트워크 매니저
    private let manager: WeatherNetworkManagerProtocol
    // init
    public init(manager: WeatherNetworkManagerProtocol) {
        self.manager = manager
    }
    // 서버에 저장된 실시간 날씨 데이터를 요청
    public func fetchWeatherData() -> Single<WeatherResponse> {
        return manager.fetchWeatherData()
    }
    // 오늘의 날씨와 현재 위치를 기반으로 주류를 추천받기 위한 데이터 요청
    public func fetchLiquorRecommendation() -> Single<WeatherLiquorResponse> {
        return manager.fetchLiquorRecommendation()
    }
    
} // closed UserNetwork
