//
//  UserRepositoryProtocol.swift
//  CheersMate
//
//  Created by 재훈 on 11/2/24.
//

import Foundation

// MARK: - Domain과 Data 영역의 의존성 역전을 위한 프로토콜(인터페이스)
public protocol UserRepositoryProtocol {
    // 사용자 로그인
    func logIn(email: String, password: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 사용자 회원가입
    func signUp(email:String, password: String, nickname: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 사용자 이메일 찾기
    func searchEmail(nickname: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 사용자 비밀번호 찾기
    func searchPassword(email: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
} // closed UserRepositoryProtocol
