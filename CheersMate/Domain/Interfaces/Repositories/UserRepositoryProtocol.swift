//
//  UserRepositoryProtocol.swift
//  CheersMate
//
//  Created by 재훈 on 11/2/24.
//

// MARK: - Domain과 Data 영역의 의존성 역전을 위한 프로토콜(인터페이스)

import Foundation
import RxSwift

public protocol UserRepositoryProtocol {
    // 사용자 로그인 API
    func logIn(email: String, password: String) -> Single<UserResponse>
    // 사용자 회원가입 API
    func signUp(email:String, password: String, nickname: String, tell: String) -> Single<UserResponse>
    // 사용자 이메일 찾기 API
    func searchEmail(nickname: String, tell: String) -> Single<UserResponse>
    // 사용자 비밀번호 찾기 API
    func searchPassword(email: String, tell: String) -> Single<UserResponse>
} 
