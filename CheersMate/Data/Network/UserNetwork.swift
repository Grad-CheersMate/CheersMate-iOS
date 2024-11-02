//
//  UserNetwork.swift
//  CheersMate
//
//  Created by 재훈 on 10/27/24.
//

import Foundation

// MARK: - 회원 API 명세서
public protocol UserNetworkProtocol {
    // 사용자 로그인 API
    func logIn(email: String, password: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 사용자 회원가입 API
    func signUp(email:String, password: String, nickname: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 사용자 이메일 찾기 API
    func searchEmail(nickname: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 사용자 비밀번호 찾기 API
    func searchPassword(email: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
} // closed UserNetworkProtocol

// MARK: - 회원 네트워크
final public class UserNetwork: UserNetworkProtocol {

    private let manager: UserNetworkManagerProtocol
    
    public init(manager: UserNetworkManagerProtocol) {
        self.manager = manager
    } // closed init
    
    // MARK: - 사용자가 로그인할 때 네트워크 요청
    public func logIn(email: String, password: String, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        manager.logIn(email: email, password: password, completion: completion)
    } // closed logIn
    
    public func signUp(email: String, password: String, nickname: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        manager.signUp(email: email, password: password, nickname: nickname, tell: tell, completion: completion)
    } // closed signUp
    
    public func searchEmail(nickname: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        manager.searchEmail(nickname: nickname, tell: tell, completion: completion)
    } // closed searchEmail
    
    public func searchPassword(email: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        manager.searchPassword(email: email, tell: tell, completion: completion)
    } // closed searchPassword
    
} // closed UserNetwork
