//
//  NetworkManager.swift
//  CheersMate
//
//  Created by 재훈 on 10/27/24.
//

import Foundation
import Alamofire

// MARK: - http://ceprj.gachon.ac.kr:60021

protocol UserNetworkManagerProtocol {
    func logIn(email: String, password: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    func signUp(email:String, password: String, nickname: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    func searchEmail(nickname: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    func searchPassword(email: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
}

final class UserNetworkManager: UserNetworkManagerProtocol {
    
    private let endpoint: String
    
    init(endpoint: String = "http://ceprj.gachon.ac.kr:60021") {
        self.endpoint = endpoint
    }
    // MARK: -  나중에 jwt를 Bearer 뒤에 추가하기
    private let tokenHeader: HTTPHeaders = {
        let tokenHeader = HTTPHeader(name: "Authorization", value: "Bearer JWT")
        return HTTPHeaders([tokenHeader])
    }()
    
    private func makeRequset(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success(let res):
                    completion(.success(res))
                case .failure(let err):
                    completion(.failure(err))
                }
            }
    }
    
    // MARK: - 로그인 요청
    func logIn(email: String, password: String, completion: @escaping (Result<UserResponse, Error>) -> Void ) {
        let url = "\(endpoint)/users/login"
        let parameters: Parameters = ["email": email, "password": password]
        makeRequset(url: url, method: .post, parameters: parameters, headers: nil, completion: completion)
    } // closed login
    
    // MARK: - 회원가입 요청
    func signUp(email: String, password: String, nickname: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        let url = "\(endpoint)/register"
        let parameters: Parameters = ["email": email, "password": password, "nickname": nickname, "tell": tell]
        makeRequset(url: url, method: .post, parameters: parameters, headers: nil, completion: completion)
    } // closed signUp
    
    // MARK: - 이메일 찾기 요청
    func searchEmail(nickname: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        let url = "\(endpoint)/emailFind"
        let parameters: Parameters = ["nickname": nickname, "tell": tell]
        makeRequset(url: url, method: .post, parameters: parameters, headers: nil, completion: completion)
    } // closed searchEmail
    
    // MARK: - 비밀번호 찾기 요청
    func searchPassword(email: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        let url = "\(endpoint)/passFind"
        let parameters: Parameters = ["email": email, "tell": tell]
        makeRequset(url: url, method: .post, parameters: parameters, headers: nil, completion: completion)
    } // closed searchPassword
    
} // closed NetworkManager
