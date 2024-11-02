//
//  LoginUseCase.swift
//  CheersMate
//
//  Created by 재훈 on 11/2/24.
//

import Foundation

// MARK: - 사용자가 첫 화면인 로그인 뷰에 진입했을 때 필요한 로그인 유스케이스 프로토콜
public protocol LoginUseCaseProtocol {
    // 사용자 로그인
    func logIn(email: String, password: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 사용자 회원가입
    func signUp(email:String, password: String, nickname: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 사용자 이메일 찾기
    func searchEmail(nickname: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 사용자 비밀번호 찾기
    func searchPassword(email: String, tell: String, completion: @escaping (Result<UserResponse, Error>) -> Void)
    // 이메일 유효성 검사
    func isValidEmail(_ email: String) -> Bool
    // 비밀번호 유효성 검사
    func isValidPassword(_ password: String) -> Bool
    // 액세스 토큰 및 리프레쉬 토큰 저장
    // func saveAccessTokenAndRefreshToken(accessToken: String, refreshToken: String)
    
} // closed UserRepositoryProtocol

// MARK: - 사용자가 첫 화면인 로그인 뷰에 진입했을 때 필요한 유스케이스(비즈니스 로직)
final public class LoginUseCase: LoginUseCaseProtocol {

    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    } // closed init
    
    // 사용자가 로그인 버튼을 클릭했을 때 
    public func logIn(email: String, password: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        repository.logIn(email: email, password: password, completion: completion)
    } // closed logIn
    
    // 사용자가 로그인 버튼을 클릭했을 때
    public func signUp(email: String, password: String, nickname: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        repository.signUp(email: email, password: password, nickname: nickname, tell: tell, completion: completion)
    } // closed signUp
    
    // 사용자가 로그인 버튼을 클릭했을 때
    public func searchEmail(nickname: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        repository.searchEmail(nickname: nickname, tell: tell, completion: completion)
    } // closed searchEmail
    
    // 사용자가 로그인 버튼을 클릭했을 때
    public func searchPassword(email: String, tell: String, completion: @escaping (Result<UserResponse, any Error>) -> Void) {
        repository.searchPassword(email: email, tell: tell, completion: completion)
    } // closed searchPassword
    
    // 사용자가 로그인에 성공하면 토큰 저장
//    public func saveAccessTokenAndRefreshToken(accessToken: String, refreshToken: String) {
//        repository
//    } // closed saveAccessTokenAndRefreshToken
    
    // 사용자가 입력한 이메일의 유효성 검사 작업
    public func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    } // closed isValidEmail
    
    // 사용자가 입력한 비밀번호의 유효성 검사 작업
    public func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9]).{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with: password)
    } // closed isValidPassword
    
    
    
} // closed LoginUseCase
