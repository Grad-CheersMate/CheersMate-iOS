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
    private let useCase: UserUseCaseProtocol
    private let isValidTextRelay = BehaviorRelay<Bool>(value: false) // 이메일과 비밀번호가 모두 유효한지 체크
    private let logInResponseRelay = PublishRelay<UserResponse>() // 로그인 성공 통신
    private let disposeBag: DisposeBag = DisposeBag()

    public init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    } // closed init
    
    public struct Input {
        let emailTextField: Driver<String> // 이메일 입력 문자열
        let passwordTextField: Driver<String> // 비밀번호 입력 문자열
        let loginButtonTapped: ControlEvent<Void> // 로그인 버튼 클릭 이벤트
    } // closed Input
    
    public struct Output {
        let loginButtonEnabled: Driver<Bool> // 로그인 버튼의 활성화 체크
        let loginResponse: Signal<UserResponse> // 로그인 요청에 관한 응답
        
    } // closed Output
    
    public func transform(input: Input) -> Output {
        
        // 이메일과 비밀번호의 유효성 검사를 실시하고 그 결과를 isValidTextRelay와 drive
        Driver.combineLatest(input.emailTextField, input.passwordTextField)
            .map { [weak self] email, password in
                (self?.useCase.isMatchingRegex(text: email, type: .email) ?? false) &&
                (self?.useCase.isMatchingRegex(text: password, type: .password) ?? false)
            }
            .drive(isValidTextRelay)
            .disposed(by: disposeBag)
        
        // 유효성 검사를 통과했을 경우만 서버와 로그인 통신을 허용
        // loginButtonTapped과 flatMapLatest 내부 Single<UserResponse>이 서로 구독상태인데 에러 발생 시 스트림이 끊어지기 때문에 주의!
        input.loginButtonTapped
            .withLatestFrom(Driver.combineLatest(input.emailTextField, input.passwordTextField, isValidTextRelay.asDriver()))
            .filter { $2 }
            .flatMapLatest{ [weak self] email, password, _ -> Single<UserResponse> in
                guard let self = self else { return Single.never() }
                return self.useCase.logIn(email: email, password: password).catch { err in // 스트림이 끊기지 않게 에러처리
                    return Single.never()
                }
            }
            .subscribe(onNext: { [weak self] userResponse in
                self?.logInResponseRelay.accept(userResponse)
            })
            .disposed(by: disposeBag)
        
        // 로그인 버튼 활성화 여부
        let loginButtonEnabled = isValidTextRelay.asDriver(onErrorJustReturn: false)
        let responseSignal = logInResponseRelay.asSignal()
        
        return Output(loginButtonEnabled: loginButtonEnabled, loginResponse: responseSignal)
    } // closed transform
    
} // closed Class
