//
//  LiquorNetworkManager.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

// MARK: - http://ceprj.gachon.ac.kr:60021
// MARK: - 추천 네트워크 매니저

import Foundation
import Alamofire
import RxSwift

// MARK: - Single을 사용하여 단일 이벤트와 에러처리만. 이벤트가 끝나면 스트림 종료. 따라서 HTTP에 적절한 Traits
public protocol RecommendNetworkManagerProtocol {
    // 사용자의 선호를 종합하여 서버에 AI 추천 주류 및 안주 결과 요청
    func requestRecommendationsForSelection(emotion: String, companion: String, volume: String) -> Single<RecommendResponse>
    // 사용자가 AI 주류 및 안주 추천 서비스를 사용하고 결과에 대한 평가를 서버에 제출
    func submitRecommendationEvaluation(emotion: String, companion: String, liquor: Liquor, rating: Int) -> Single<RecommendResultResponse>
}

final public class RecommendNetworkManager: RecommendNetworkManagerProtocol {
    
    private let endpoint: String
    
    public init(endpoint: String = "http://ceprj.gachon.ac.kr:60021") {
        self.endpoint = endpoint
    }
    
    // jwt 추가
    private let tokenHeader: HTTPHeaders = {
        let tokenHeader = HTTPHeader(name: "Authorization", value: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0QG5hdmVyLmNvbSIsInJvbGUiOiJVU0VSIiwiaXNzIjoiVG9Eb0l0IiwiaWF0IjoxNzMyMTIyMjY0LCJleHAiOjE3MzIyMDg2NjR9.L-v54Em5MAKZrv2A4FEYdHC1kvlP_kEis4dcr35Wtvvkk5KbYVmNdNU2lbze0WcxXT_Y1cJpDaBNP5Vq02-onQ")
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
    
    // 사용자의 선호를 종합하여 서버에 AI 추천 주류 및 안주 결과 요청
    public func requestRecommendationsForSelection(emotion: String, companion: String, volume: String) -> Single<RecommendResponse> {
        let url = "\(endpoint)/api/recommend"
        let parameters: Parameters = ["emotion": emotion, "companion": companion, "volume": volume]
        return makeRequest(url: url, method: .post, parameters: parameters, headers: tokenHeader)
    }
    
    // 사용자가 AI 주류 및 안주 추천 서비스를 사용하고 결과에 대한 평가를 서버에 제출
    public func submitRecommendationEvaluation(emotion: String, companion: String, liquor: Liquor, rating: Int) -> Single<RecommendResultResponse> {
        let url = "\(endpoint)/api/recommend/evaluate"
        let parameters: Parameters = ["emotion": emotion, "companion": companion, "liquor": [ "name": liquor.name  ], "rating": rating]
        return makeRequest(url: url, method: .post, parameters: parameters, headers: tokenHeader)
    }
    
} // closed RecommendNetworkManager
