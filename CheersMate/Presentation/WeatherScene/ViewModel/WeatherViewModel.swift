//
//  WeatherViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/18/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol WeatherViewModelProtocol {
    func transform(input: WeatherViewModel.Input) -> WeatherViewModel.Output
}

final public class WeatherViewModel: WeatherViewModelProtocol {
    // 프로퍼티
    private let useCase: WeatherUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    private let weatherRelay = BehaviorRelay<Weather?>(value: nil) // 날씨 정보
    private let weatherLiquorRelay = PublishRelay<[LiquorRecommendation]>() // 날씨맞춤 추천 주류
    private let errorRealy = BehaviorRelay<Error?>(value: nil) // 에러
    
    // init
    public init(useCase: WeatherUseCaseProtocol) {
        self.useCase = useCase
        fetchWeatherData()
        fetchLiquorRecommendation()
    }
    // Input
    public struct Input {
    }
    // Output
    public struct Output {
        let responseWeatherData: Observable<(Weather?, [LiquorRecommendation])>
    }
    // transform
    public func transform(input: Input) -> Output {
        let result = Observable.combineLatest(weatherRelay.asObservable(), weatherLiquorRelay.asObservable())
        return Output(responseWeatherData: result)
    }
    
} // closed HomeViewModel

extension WeatherViewModel {
    // 실시간 날씨 정보
    private func fetchWeatherData() {
        useCase.fetchWeatherData()
            .subscribe { [weak self] response in
                if response.httpCode == 200 && response.result { // 요청에 대한 응답 정상 체크
                    self?.weatherRelay.accept(response.weather)
                }
            } onFailure: { [weak self] error in
                self?.errorRealy.accept(error)
            }
            .disposed(by: disposeBag)
    }
    // 실시간 날씨 맞춤 추천 주류
    private func fetchLiquorRecommendation() {
        useCase.fetchLiquorRecommendation()
            .subscribe { [weak self] response in
                if response.httpCode == 200 && response.result { // 요청에 대한 응답 정상 체크
                    self?.weatherLiquorRelay.accept(response.data.recommend)
                }
            } onFailure: { [weak self] error in
                self?.errorRealy.accept(error)
            }
            .disposed(by: disposeBag)
    }
    
} // closed HomeViewModel
