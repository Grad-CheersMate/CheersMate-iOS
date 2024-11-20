//
//  WeatherNetworkManager.swift
//  CheersMate
//
//  Created by 재훈 on 11/18/24.
//
import Foundation
import Alamofire
import RxSwift

// MARK: - http://ceprj.gachon.ac.kr:60021

// Single을 사용하여 단일 이벤트와 에러처리만. 이벤트가 끝나면 스트림 종료. 따라서 HTTP에 적절한 Traits
public protocol WeatherNetworkManagerProtocol {
    // 서버에 저장된 실시간 날씨 데이터를 요청
    func fetchWeatherData() -> Single<WeatherResponse>
    // 오늘의 날씨와 현재 위치를 기반으로 주류를 추천받기 위한 데이터 요청
    func fetchLiquorRecommendation() -> Single<WeatherLiquorResponse>
}

// 날씨 네트워크 매니저
final public class WeatherNetworkManager: WeatherNetworkManagerProtocol {
    // 엔드 포인트
    private let endpoint: String
    // init
    public init(endpoint: String = "http://ceprj.gachon.ac.kr:60021") {
        self.endpoint = endpoint
    }
    // jwt 추가
    private let tokenHeader: HTTPHeaders = {
        let tokenHeader = HTTPHeader(name: "Authorization", value: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0QG5hdmVyLmNvbSIsInJvbGUiOiJVU0VSIiwiaXNzIjoiVG9Eb0l0IiwiaWF0IjoxNzMyMDM1Njg1LCJleHAiOjE3MzIxMjIwODV9.pgxNi8Jqyn7E_9DesnpS109asG46nj37mm9HZc4fSkkZeQQ8u1ddtmcuJ0xzQNXp2HpF8OgO0tjKaXjJzQXMgQ")
        return HTTPHeaders([tokenHeader])
    }()
    // 리퀘스트 생성
    private func makeRequest<T: Codable>(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> Single<T> {
        return Single.create { single -> Disposable in
            let result = AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let res):
                        single(.success(res))
                    case .failure(let err):
                        single(.failure(err))
                    }
                }
            return Disposables.create { result.cancel() }
        }
    }
    // 서버에 저장된 실시간 날씨 데이터를 요청
    public func fetchWeatherData() -> Single<WeatherResponse> {
        let url = "\(endpoint)/weather"
        return makeRequest(url: url, method: .get, parameters: nil, headers: tokenHeader)
    }
    // 오늘의 날씨와 현재 위치를 기반으로 주류를 추천받기 위한 데이터 요청
    public func fetchLiquorRecommendation() -> Single<WeatherLiquorResponse> {
        let url = "\(endpoint)/api/recommend/weather"
        return makeRequest(url: url, method: .get, parameters: nil, headers: tokenHeader)
    }
    
} // closed NetworkManager
