//
//  NetworkManager.swift
//  CheersMate
//
//  Created by 재훈 on 10/27/24.
//

import Foundation
import Alamofire
import RxSwift

// MARK: - http://ceprj.gachon.ac.kr:60021

// MARK: - Single을 사용하여 단일 이벤트와 에러처리만. 이벤트가 끝나면 스트림 종료. 따라서 HTTP에 적절한 Traits
public protocol UserNetworkManagerProtocol {
    func logIn(email: String, password: String) -> Single<UserResponse>
    func signUp(email:String, password: String, nickname: String, tell: String) -> Single<UserResponse>
    func searchEmail(nickname: String, tell: String) -> Single<UserResponse>
    func searchPassword(email: String, tell: String) -> Single<UserResponse>
}

public final class UserNetworkManager: UserNetworkManagerProtocol {
    
    private let endpoint: String
    
    public init(endpoint: String = "http://ceprj.gachon.ac.kr:60021") {
        self.endpoint = endpoint
    }
    
    private func makeRequest<T: Codable>(url: String, method: HTTPMethod, parameters: Parameters?) -> Single<T> {
        return Single.create { single -> Disposable in
            let result = AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default)
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
    
    // 로그인 요청
    public func logIn(email: String, password: String) -> Single<UserResponse> {
        let url = "\(endpoint)/users/login"
        let parameters: Parameters = ["email": email, "password": password]
        return makeRequest(url: url, method: .post, parameters: parameters)
    }
    
    // 회원가입 요청
    public func signUp(email: String, password: String, nickname: String, tell: String) -> Single<UserResponse> {
        let url = "\(endpoint)/users/register"
        let parameters: Parameters = ["email": email, "password": password, "nickname": nickname, "tell": tell]
        return makeRequest(url: url, method: .post, parameters: parameters)
    }
    
    // 이메일 찾기 요청
    public func searchEmail(nickname: String, tell: String) -> Single<UserResponse> {
        let url = "\(endpoint)/users/emailFind"
        let parameters: Parameters = ["nickname": nickname, "tell": tell]
        return makeRequest(url: url, method: .post, parameters: parameters)
    }
    
    // 비밀번호 찾기 요청
    public func searchPassword(email: String, tell: String) -> Single<UserResponse> {
        let url = "\(endpoint)/users/passFind"
        let parameters: Parameters = ["email": email, "tell": tell]
        return makeRequest(url: url, method: .post, parameters: parameters)
    }
    
} // closed UserNetworkManager
