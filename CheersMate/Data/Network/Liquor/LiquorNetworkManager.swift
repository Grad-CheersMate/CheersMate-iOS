//
//  LiquorNetworkManager.swift
//  CheersMate
//
//  Created by 재훈 on 11/20/24.
//

import Foundation
import Alamofire
import RxSwift

// MARK: - http://ceprj.gachon.ac.kr:60021

// Single을 사용하여 단일 이벤트와 에러처리만. 이벤트가 끝나면 스트림 종료. 따라서 HTTP에 적절한 Traits
public protocol LiquorNetworkManagerProtocol {
    // 카테고리 별 주류 데이터 조회
    func fetchLiquorListByCategory(category: ProductType, page: Int) -> Single<LiquorsResponse>
    // 주류 데이터 상세 조회
    func fetchLiquorDetailsById(liquorId: Int) -> Single<LiquorsResponse>
    // 주류 데이터 검색
    func searchLiquors(keyword: String, page: Int) -> Single<LiquorsResponse>
}

// 주류 네트워크 매니저
final public class LiquorNetworkManager: LiquorNetworkManagerProtocol {
    // 엔드 포인트
    private let endpoint: String
    // init
    public init(endpoint: String = "http://ceprj.gachon.ac.kr:60021") {
        self.endpoint = endpoint
    }
    // jwt 추가
    private let tokenHeader: HTTPHeaders = {
        let tokenHeader = HTTPHeader(name: "Authorization", value: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0QG5hdmVyLmNvbSIsInJvbGUiOiJVU0VSIiwiaXNzIjoiVG9Eb0l0IiwiaWF0IjoxNzMyNDQwODc3LCJleHAiOjE3MzI1MjcyNzd9.D0anPVkpv8bHc2wSXQjWKj6DiKocZJ8wdsG3pE3aqG7dPxvlP5KH3XRZafo8z0piCbD93v5VQuIM45F_9vSCYQ")
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
    
    // 카테고리 별 주류 데이터 조회: 카테고리 타입(= 주류 타입)을 받고 rawValue로 변경
    public func fetchLiquorListByCategory(category: ProductType, page: Int = 0) -> Single<LiquorsResponse> {
        let url = "\(endpoint)/api/liquors/category?category=\(category.rawValue)&page=\(page)"
        return makeRequest(url: url, method: .get, parameters: nil, headers: tokenHeader)
    }
    
    // 주류 데이터 상세 조회: 주류 고유 ID를 전달
    public func fetchLiquorDetailsById(liquorId: Int) -> Single<LiquorsResponse> {
        let url = "\(endpoint)/api/liquors/\(liquorId)"
        return makeRequest(url: url, method: .get, parameters: nil, headers: tokenHeader)
    }
    
    // 주류 데이터 검색
    public func searchLiquors(keyword: String, page: Int) -> Single<LiquorsResponse> {
        let url = "\(endpoint)/api/liquors/search?keyword=\(keyword)&page=\(page)"
        return makeRequest(url: url, method: .get, parameters: nil, headers: tokenHeader)
    }
    
} // closed LiquorNetworkManager
