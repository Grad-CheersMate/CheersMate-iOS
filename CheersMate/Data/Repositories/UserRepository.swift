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
    
    // init
    public init(network: UserNetworkProtocol) {
        self.network = network
    }
    
    // 사용자가 로그인을 할 때 서버에 인증요청
    public func login(email: String, password: String) -> Single<UserResponse> {
        return network.login(email: email, password: password)
    }
    
    // 사용자가 회원가입을 할 때 서버에 인증요청
    public func signUp(email: String, password: String, nickname: String, tell: String) -> Single<UserResponse> {
        return network.signUp(email: email, password: password, nickname: nickname, tell: tell)
    }
    
    // 사용자가 이메일 찾기를 할 때 서버에 인증요청
    public func findEmail(nickname: String, tell: String) -> Single<UserResponse> {
        return network.findEmail(nickname: nickname, tell: tell)
    }
    
    // 사용자가 비밀번호 찾기를 할 때 서버에 인증요청
    public func findPassword(email: String, tell: String) -> Single<UserResponse> {
        return network.findPassword(email: email, tell: tell)
    }
    
} // closed UserRepository
