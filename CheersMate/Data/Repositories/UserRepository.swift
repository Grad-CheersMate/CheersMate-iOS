//
//  UserRepository.swift
//  CheersMate
//
//  Created by 재훈 on 10/27/24.
//

import Foundation

// MARK: - DB 또는 Network를 통해 Domain과 Data 영역을 연결해주는 Repository
// MARK: - DB는 Realm을 사용
public class UserRepository: UserRepositoryProtocol {
    
    private let network: UserNetworkProtocol
    
    public init(network: UserNetworkProtocol) {
        self.network = network
    }
    
    // 사용자가 로그인을 할 때 서버에 인증요청
    public func logIn(email: String, password: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        network.logIn(email: email, password: password, completion: completion)
    }
    
    // 사용자가 회원가입을 할 때 서버에 인증요청
    public func signUp(email: String, password: String, nickname: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        network.signUp(email: email, password: password, nickname: nickname, tell: tell, completion: completion)
    }
    
    // 사용자가 이메일 찾기를 할 때 서버에 인증요청
    public func searchEmail(nickname: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        network.searchEmail(nickname: nickname, tell: tell, completion: completion)
    }
    
    // 사용자가 비밀번호 찾기를 할 때 서버에 인증요청
    public func searchPassword(email: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        network.searchPassword(email: email, tell: tell, completion: completion)
    }
    
}
