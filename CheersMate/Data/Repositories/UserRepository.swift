//
//  UserRepository.swift
//  CheersMate
//
//  Created by 재훈 on 10/27/24.
//

import Foundation
import RxSwift

// MARK: - DB 또는 Network를 통해 Domain과 Data 영역을 연결해주는 Repository
// MARK: - DB는 Realm을 사용
public class UserRepository: UserRepositoryProtocol {
    
    private let network: UserNetworkProtocol
    
    public init(network: UserNetworkProtocol) {
        self.network = network
    } // closed init
    
    // 사용자가 로그인을 할 때 서버에 인증요청
    public func logIn(email: String, password: String) -> Single<UserResponse> {
        return network.logIn(email: email, password: password)
    } // closed logIn
    
    // 사용자가 회원가입을 할 때 서버에 인증요청
    public func signUp(email: String, password: String, nickname: String, tell: String) -> Single<UserResponse> {
        return network.signUp(email: email, password: password, nickname: nickname, tell: tell)
    } // closed signUp
    
    // 사용자가 이메일 찾기를 할 때 서버에 인증요청
    public func searchEmail(nickname: String, tell: String) -> Single<UserResponse> {
        return network.searchEmail(nickname: nickname, tell: tell)
    } // closed searchEmail
    
    // 사용자가 비밀번호 찾기를 할 때 서버에 인증요청
    public func searchPassword(email: String, tell: String) -> Single<UserResponse> {
        return network.searchPassword(email: email, tell: tell)
    } // closed searchPassword
    
} // closed UserRepository
