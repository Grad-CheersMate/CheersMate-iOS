//
//  LoginViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 10/20/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol LoginViewModelProtocol {
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output
}

public final class LoginViewModel: LoginViewModelProtocol {
    private let useCase: UserUseCaseProtocol
    private let isValidEmailRelay = PublishRelay<Bool>() // 이메일 정규식 릴레이
    private let isValidPasswordRelay = PublishRelay<Bool>() // 비밀번호 정규식 릴레이
    private let successRelay = PublishRelay<Void>() // 로그인 성공 릴레이
    private let failureRelay = PublishRelay<Void>() // 로그인 실패 릴레이
    private let disposeBag: DisposeBag = DisposeBag()
    
    // init
    public init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
    
    // Input
    public struct Input {
        let emailTextField: Observable<String> // 이메일 입력 문자열
        let passwordTextField: Observable<String> // 비밀번호 입력 문자열
        let loginButtonTapped: Observable<Void> // 회원가입 버튼 클릭 이벤트
    }
    
    // Output
    public struct Output {
        let isValidEmail: Observable<Bool> // 이메일 주소 정규식 검증 결과
        let isValidPassword: Observable<Bool> // 비밀번호 정규식 검증 결과
        let isLoginButtonEnabled: Observable<Bool> // 로그인 버튼의 활성화 체크
        let loginSuccess: PublishRelay<Void> // 로그인 성공
        let loginFailure: PublishRelay<Void> // 로그인 실패
    }
    
    // transform
    public func transform(input: Input) -> Output {
        
        // 사용자가 입력한 이메일 텍스트 값
        input.emailTextField
            .subscribe(onNext: { [weak self] email in
                guard let self = self else { return }
                let result = useCase.isMatchingRegex(text: email, type: .email) // 이메일 주소 정규식 검증
                isValidEmailRelay.accept(result) // 검증 결과 전달
            })
            .disposed(by: disposeBag)
        
        // 사용자가 입력한 비밀번호 텍스트 값
        input.passwordTextField
            .subscribe(onNext: { [weak self] password in
                guard let self = self else { return }
                let result = useCase.isMatchingRegex(text: password, type: .password) // 비밀번호 정규식 검증
                isValidPasswordRelay.accept(result) // 검증 결과 전달
            })
            .disposed(by: disposeBag)
        
        // 사용자가 로그인 버튼을 클릭했을 때 이벤트
        input.loginButtonTapped
            .withLatestFrom(Observable.combineLatest(input.emailTextField, input.passwordTextField)) // 클릭이 들어올 때 combineLatest로 종합
            .subscribe(onNext: { [weak self] email, password in
                guard let self = self else { return }
                requestLogin(user: User(email: email, password: password, nickname: nil, tell: nil))
            })
            .disposed(by: disposeBag)
        
        // 로그인 버튼의 활성화 여부
        let isLoginButtonEnable = Observable.combineLatest(isValidEmailRelay, isValidPasswordRelay) { $0 && $1 }
        
        
        return Output(isValidEmail: isValidEmailRelay.asObservable(),
                      isValidPassword: isValidPasswordRelay.asObservable(),
                      isLoginButtonEnabled: isLoginButtonEnable,
                      loginSuccess: successRelay,
                      loginFailure: failureRelay)
    }
    
} // closed LoginViewModel

// extension
extension LoginViewModel {
    // 로그인 서버에 요청
    private func requestLogin(user: User) {
        useCase.login(user: user)
            .subscribe { [weak self] res in
                if res.result && res.httpCode == 200 {
                    self?.successRelay.accept(()) // 성공 트리거
                    self?.saveTokens(accessToken: res.accessToken, refreshToken: res.refreshToken) // 토큰 저장
                }
            } onFailure: { [weak self] error in
                self?.failureRelay.accept(()) // 실패 트리거
            }
            .disposed(by: disposeBag)
    }
    
    // 액세스 토큰과 리프레쉬 토큰 저장
    private func saveTokens(accessToken: String?, refreshToken: String?) {
        guard let accessToken = accessToken,
              let refreshToken = refreshToken else { return }
        useCase.saveAccessTokenAndRefreshToken(accessToken: accessToken, refreshToken: refreshToken)
    }
    
}
