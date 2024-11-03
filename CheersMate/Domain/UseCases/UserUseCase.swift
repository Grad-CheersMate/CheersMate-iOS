//
//  LoginUseCase.swift
//  CheersMate
//
//  Created by 재훈 on 11/2/24.
//

import Foundation
import RxSwift

// MARK: - 텍스트 타입에 따른 정규식 검사 분류
public enum textType {
    case email
    case password
    case nickname
    case tell
}

// MARK: - 사용자가 첫 화면인 로그인 뷰에 진입했을 때 필요한 로그인 유스케이스 프로토콜
public protocol UserUseCaseProtocol {
    // 사용자 로그인
    func logIn(email: String, password: String) -> Single<UserResponse>
    // 사용자 회원가입
    func signUp(email:String, password: String, nickname: String, tell: String) -> Single<UserResponse>
    // 사용자 이메일 찾기
    func searchEmail(nickname: String, tell: String) -> Single<UserResponse>
    // 사용자 비밀번호 찾기
    func searchPassword(email: String, tell: String) -> Single<UserResponse>
    // 사용자 이메일, 비밀번호, 닉네임, 전화번호의 유효성 검사 작업
    func isMatchingRegex(text: String, type: textType) -> Bool
    // 액세스 토큰 및 리프레쉬 토큰 저장
    // func saveAccessTokenAndRefreshToken(accessToken: String, refreshToken: String)
    
} // closed UserRepositoryProtocol

// MARK: - 사용자가 첫 화면인 로그인 뷰에 진입했을 때 필요한 유스케이스(비즈니스 로직)
final public class UserUseCase: UserUseCaseProtocol {

    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    } // closed init
    
    // 사용자가 로그인 버튼을 클릭했을 때 
    public func logIn(email: String, password: String) -> Single<UserResponse> {
        return repository.logIn(email: email, password: password)
    } // closed logIn
    
    // 사용자가 회원가입 버튼을 클릭했을 때
    public func signUp(email: String, password: String, nickname: String, tell: String) -> Single<UserResponse> {
        return repository.signUp(email: email, password: password, nickname: nickname, tell: tell)
    } // closed signUp
    
    // 사용자가 이메일 찾기 버튼을 클릭했을 때
    public func searchEmail(nickname: String, tell: String) -> Single<UserResponse> {
        return repository.searchEmail(nickname: nickname, tell: tell)
    } // closed searchEmail
    
    // 사용자가 비밀번호 찾기 버튼을 클릭했을 때
    public func searchPassword(email: String, tell: String) -> Single<UserResponse> {
        return repository.searchPassword(email: email, tell: tell)
    } // closed searchPassword
    
    // 사용자가 로그인에 성공하면 토큰 저장
//    public func saveAccessTokenAndRefreshToken(accessToken: String, refreshToken: String) {
//        repository
//    } // closed saveAccessTokenAndRefreshToken
    
    // 사용자가 입력한 이메일, 비밀번호, 닉네임, 전화번호의 유효성 검사 작업
    public func isMatchingRegex(text: String, type: textType) -> Bool {
        let textRegEx: String
        switch type {
        case .email:
            textRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .password:
            textRegEx = "^(?=.*[a-z])(?=.*[0-9]).{8,}$"
        case .nickname:
            textRegEx = "^[가-힣a-zA-Z0-9_]{2,20}$"
        case .tell:
            textRegEx = "^010\\-([0-9]{4})\\-([0-9]{4})"
        }
        let textPredicate = NSPredicate(format: "SELF MATCHES %@", textRegEx)
        return textPredicate.evaluate(with: text)
    } // closed isMatchingRegex

    
} // closed LoginUseCase
