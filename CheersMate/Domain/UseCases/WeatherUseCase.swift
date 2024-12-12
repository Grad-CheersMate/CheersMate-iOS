//
//  WeatherUseCase.swift
//  CheersMate
//
//  Created by 재훈 on 11/18/24.
//

import Foundation
import RxSwift
import RxCocoa


public protocol WeatherUseCaseProtocol {
    // 사용자가 날씨 맞춤 주류 추천 서비스를 사용할 때, 서버에 저장된 날씨 데이터 API 호출하기
    func fetchWeatherData() -> Single<WeatherResponse>
    
    // 사용자가 날씨 맞춤 주류 추천 서비스를 사용할 때, 날씨 맞춤 추천 주류 데이터 API 호출하기
    func fetchLiquorRecommendation() -> Single<WeatherLiquorResponse>
}


public final class WeatherUseCase: WeatherUseCaseProtocol {
    // 리포지토리
    private let repository: WeatherRepositoryProtocol
    
    // init
    public init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
    
    // 서버에 저장된 실시간 날씨 데이터를 요청
    public func fetchWeatherData() -> Single<WeatherResponse> {
        return repository.fetchWeatherData()
    }
    
    // 오늘의 날씨와 현재 위치를 기반으로 주류를 추천받기 위한 데이터 요청
    public func fetchLiquorRecommendation() -> Single<WeatherLiquorResponse> {
        return repository.fetchLiquorRecommendation()
    }
    
} // closed WeatherUseCase
