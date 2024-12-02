//
//  LoginUseCase.swift
//  CheersMate
//
//  Created by 재훈 on 11/2/24.
//

import Foundation
import RxSwift

// 사용자가 첫 화면인 로그인 뷰에 진입했을 때 필요한 로그인 유스케이스 프로토콜
public protocol UserUseCaseProtocol {
    // 사용자 로그인
    func logIn(email: String, password: String) -> Single<UserResponse>
    
    // 사용자 회원가입
    func signUp(registrationInfo: User) -> Single<UserResponse>
    
    // 사용자 이메일 찾기
    func searchEmail(nickname: String, tell: String) -> Single<UserResponse>
    
    // 사용자 비밀번호 찾기
    func searchPassword(email: String, tell: String) -> Single<UserResponse>
    
    // 사용자 이메일, 비밀번호, 닉네임, 전화번호의 유효성 검사 작업
    func isMatchingRegex(text: String, type: RegExType) -> Bool
    
    // 액세스 토큰 및 리프레쉬 토큰 저장
    // func saveAccessTokenAndRefreshToken(accessToken: String, refreshToken: String)
    
} // closed UserRepositoryProtocol

// 사용자가 첫 화면인 로그인 뷰에 진입했을 때 필요한 유스케이스(비즈니스 로직)
final public class UserUseCase: UserUseCaseProtocol {

    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    // 사용자가 로그인 버튼을 클릭했을 때 
    public func logIn(email: String, password: String) -> Single<UserResponse> {
        return repository.logIn(email: email, password: password)
    }
    
    // 사용자가 회원가입 버튼을 클릭했을 때
    public func signUp(registrationInfo: User) -> Single<UserResponse> {
        return repository.signUp(email: registrationInfo.email!, password: registrationInfo.password!, nickname: registrationInfo.nickname!, tell: registrationInfo.tell!)
    }
    
    // 사용자가 이메일 찾기 버튼을 클릭했을 때
    public func searchEmail(nickname: String, tell: String) -> Single<UserResponse> {
        return repository.searchEmail(nickname: nickname, tell: tell)
    }
    
    // 사용자가 비밀번호 찾기 버튼을 클릭했을 때
    public func searchPassword(email: String, tell: String) -> Single<UserResponse> {
        return repository.searchPassword(email: email, tell: tell)
    }
    
    // 사용자가 로그인에 성공하면 토큰 저장
//    public func saveAccessTokenAndRefreshToken(accessToken: String, refreshToken: String) {
//        repository
//    } // closed saveAccessTokenAndRefreshToken
    
    // 사용자가 입력한 이메일, 비밀번호, 닉네임, 전화번호의 정규식 검사 작업
    public func isMatchingRegex(text: String, type: RegExType) -> Bool {
        let textRegEx: String
        switch type {
        case .email:
            textRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .password:
            textRegEx = "^(?=.*[a-z])(?=.*[0-9]).{8,}$"
        case .tell:
            textRegEx = "^01[0-9]{8,9}$"
        }
        let textPredicate = NSPredicate(format: "SELF MATCHES %@", textRegEx)
        return textPredicate.evaluate(with: text)
    }

    
} // closed LoginUseCase
