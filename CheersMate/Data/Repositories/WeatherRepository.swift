//
//  WeatherRepository.swift
//  CheersMate
//
//  Created by 재훈 on 11/18/24.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Domain과 Data 영역을 연결해주는 Repository
// MARK: - DB는 Realm을 사용

public final class WeatherRepository: WeatherRepositoryProtocol {
    // 네트워크 객체
    private let network: WeatherNetworkProtocol
    
    // init
    public init(network: WeatherNetworkProtocol) {
        self.network = network
    }
    
    // 서버에 저장된 실시간 날씨 데이터를 요청
    public func fetchWeatherData() -> Single<WeatherResponse> {
        return network.fetchWeatherData()
    }
    
    // 오늘의 날씨와 현재 위치를 기반으로 주류를 추천받기 위한 데이터 요청
    public func fetchLiquorRecommendation() -> Single<WeatherLiquorResponse> {
        return network.fetchLiquorRecommendation()
    }
    
} // closed UserRepository
