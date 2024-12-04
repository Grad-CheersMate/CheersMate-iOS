//
//  UserNetwork.swift
//  CheersMate
//
//  Created by 재훈 on 10/27/24.
//

import Foundation
import RxSwift

// 회원 API 명세서
public protocol UserNetworkProtocol {
    // 사용자 로그인 API
    func login(email: String, password: String) -> Single<UserResponse>
    
    // 사용자 회원가입 API
    func signUp(email:String, password: String, nickname: String, tell: String) -> Single<UserResponse>
    
    // 사용자 이메일 찾기 API
    func findEmail(nickname: String, tell: String) -> Single<UserResponse>
    
    // 사용자 비밀번호 찾기 API
    func findPassword(email: String, tell: String) -> Single<UserResponse>
}

// 사용자 네트워크
public final class UserNetwork: UserNetworkProtocol {

    private let manager: UserNetworkManagerProtocol
    
    // init
    public init(manager: UserNetworkManagerProtocol) {
        self.manager = manager
    }
    
    // MARK: - 사용자와 관련된 네트워크 요청
    
    // 사용자 로그인
    public func login(email: String, password: String) -> Single<UserResponse> {
        return manager.login(email: email, password: password)
    }
    
    // 사용자 회원가입
    public func signUp(email: String, password: String, nickname: String, tell: String) -> Single<UserResponse> {
        return manager.signUp(email: email, password: password, nickname: nickname, tell: tell)
    }
    
    // 사용자 이메일 찾기
    public func findEmail(nickname: String, tell: String)-> Single<UserResponse> {
        return manager.findEmail(nickname: nickname, tell: tell)
    }
    
    // 사용자 비밀번호 찾기
    public func findPassword(email: String, tell: String) -> Single<UserResponse> {
        return manager.findPassword(email: email, tell: tell)
    }
    
} // closed UserNetwork
