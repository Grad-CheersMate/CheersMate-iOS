//
//  LiquorNetworkManager.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation
import Alamofire
import RxSwift

// MARK: - http://ceprj.gachon.ac.kr:60021

// MARK: - Single을 사용하여 단일 이벤트와 에러처리만. 이벤트가 끝나면 스트림 종료. 따라서 HTTP에 적절한 Traits
public protocol LiquorNetworkManagerProtocol {
    func requestRecommendationsForSelection(emotion: String, companion: String, preferredLiquor: String, preferredDegree: Int) -> Single<LiquorResponse>
}

// MARK: - 주류 네트워크 매니저
final public class LiquorNetworkManager: LiquorNetworkManagerProtocol {
    
    private let endpoint: String
    
    public init(endpoint: String = "http://ceprj.gachon.ac.kr:60021") {
        self.endpoint = endpoint
    }
    // MARK: -  나중에 jwt를 Bearer 뒤에 추가하기
    private let tokenHeader: HTTPHeaders = {
        let tokenHeader = HTTPHeader(name: "Authorization", value: "Bearer JWT")
        return HTTPHeaders([tokenHeader])
    }() // closed tokenHeader
    
    private func makeRequset<T: Codable>(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> Single<T> {
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
    } // closed makeRequset
    
    // MARK: - 사용자의 선호를 종합하여 서버에 AI 추천 주류 및 안주 결과 요청
    public func requestRecommendationsForSelection(emotion: String, companion: String, preferredLiquor: String, preferredDegree: Int) -> Single<LiquorResponse> {
        let url = "\(endpoint)/api/liquors/recommend"
        let parameters: Parameters = ["emotion": emotion, "companion": companion, "preferredLiquor": preferredLiquor, "preferredDegree": preferredDegree]
        return makeRequset(url: url, method: .post, parameters: parameters, headers: nil)
    } // closed recommendLiquor
    
    
    
} // closed NetworkManager

