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

final public class LoginViewModel: LoginViewModelProtocol {
    
    private let useCase: LoginUseCaseProtocol
    private let emailTextRelay = BehaviorRelay<String>(value: "")
    private let passwordTextRelay = BehaviorRelay<String>(value: "")
    private let isValidTextRelay = BehaviorRelay<Bool>(value: false)
    private let responseRelay = PublishRelay<Result<UserResponse, Error>>()
    private let disposeBag: DisposeBag = DisposeBag()

    public init(useCase: LoginUseCaseProtocol) {
        self.useCase = useCase
    } // closed init
    
    public struct Input {
        let emailTextField: Driver<String> // 이메일 입력 문자열
        let passwordTextField: Driver<String> // 비밀번호 입력 문자열
        let loginButtonTapped: ControlEvent<Void> // 로그인 버튼 클릭 이벤트
    } // closed Input
    
    public struct Output {
        let loginButtonEnabled: Driver<Bool>
        let loginResponse: Signal<Result<UserResponse, Error>>
        
    } // closed Output
    
    public func transform(input: Input) -> Output {
        
        // emailTextField를 구독하고 텍스트를 emailTextRelay로 전달
        input.emailTextField
            .drive(onNext: { [weak self] text in
                self?.emailTextRelay.accept(text)
            }).disposed(by: disposeBag)
        
        // passwordTextField를 구독하고 텍스트를 passwordTextRelay로 전달
        input.passwordTextField
            .drive(onNext: { [weak self] text in
                self?.passwordTextRelay.accept(text)
            }).disposed(by: disposeBag)
        
        // 이메일과 비밀번호의 유효성 검사를 실시하고 그 결과를 isValidTextRelay와 bind
        Observable.combineLatest(emailTextRelay.asObservable(), passwordTextRelay.asObservable())
            .map { [weak self] email, password in
                return self?.useCase.isValidEmail(email) ?? false && self?.useCase.isValidPassword(password) ?? false
            }
            .bind(to: isValidTextRelay)
            .disposed(by: disposeBag)
        
        // 유효성 검사를 통과했을 경우만 서버와 로그인 통신을 허용
        input.loginButtonTapped
            .withLatestFrom(Observable.combineLatest(emailTextRelay.asObservable(), passwordTextRelay.asObservable(), isValidTextRelay.asObservable()))
            .filter { $2 }
            .subscribe(onNext: { [weak self] email, password, _ in
                self?.useCase.logIn(email: email, password: password, completion: { response in
                    switch response {
                    case .success(let res):
                        self?.responseRelay.accept(.success(res))
                    case .failure(let err):
                        self?.responseRelay.accept(.failure(err))
                    }
                })
            })
            .disposed(by: disposeBag)
        
        // 로그인 버튼 활성화 여부
        let loginButtonEnabled = isValidTextRelay.asDriver(onErrorJustReturn: false)
        let responseSignal = responseRelay.asSignal()
        
        return Output(loginButtonEnabled: loginButtonEnabled, loginResponse: responseSignal)
    } // closed transform
    
} // closed Class
