//
//  SignUpViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/3/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol SignUpViewModelProtocol {
    func transform(input: SignUpViewModel.Input) -> SignUpViewModel.Output
}

final public class SignUpViewModel: SignUpViewModelProtocol {
    private let useCase: UserUseCaseProtocol
    private let isValidTextRelay = BehaviorRelay<Bool>(value: false) // 이메일, 비밀번호, 전화번호가 모두 유효한지 체크
    private let responseRelay = PublishRelay<UserResponse>()
    private let disposeBag: DisposeBag = DisposeBag()

    public init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    } // closed init
    
    public struct Input {
        let emailTextField: Driver<String> // 이메일 입력 문자열
        let passwordTextField: Driver<String> // 비밀번호 입력 문자열
        let nicknameTextField: Driver<String> // 닉네임 입력 문자열
        let tellTextField: Driver<String> // 전화번호 입력 문자열
        let signUpButtonTapped: ControlEvent<Void> // 회원가입 버튼 클릭 이벤트
    } // closed Input
    
    public struct Output {
        let signUpButtonEnabled: Driver<Bool> // 회원가입 버튼의 활성화 체크
        let signUpResponse: Signal<UserResponse> // 로그인 요청에 관한 응답
    } // closed Output
    
    public func transform(input: Input) -> Output {
        
        Driver.combineLatest(
            input.emailTextField,
            input.passwordTextField,
            input.nicknameTextField,
            input.tellTextField)
            .map { [weak self] email, password, nickname, tell in
                (self?.useCase.isMatchingRegex(text: email, type: .email) ?? false) &&
                (self?.useCase.isMatchingRegex(text: password, type: .password) ?? false) &&
                (self?.useCase.isMatchingRegex(text: nickname, type: .nickname) ?? false) &&
                (self?.useCase.isMatchingRegex(text: tell, type: .tell) ?? false)
            }
            .drive(isValidTextRelay)
            .disposed(by: disposeBag)
        
        // flatMapLatest는 내부 옵저버블을 구독하는데 이때 에러가 발생하면 스트림이 끊어지니 주의할 것!
        input.signUpButtonTapped
            .withLatestFrom(Observable.combineLatest(input.emailTextField.asObservable(),
                                                     input.passwordTextField.asObservable(),
                                                     input.nicknameTextField.asObservable(),
                                                     input.tellTextField.asObservable(),
                                                     isValidTextRelay))
            .filter { $4 }
            .flatMapLatest { [weak self] email, password, nickname, tell, _ -> Single<UserResponse> in
                guard let self = self else { return Single.never() }
                return self.useCase.signUp(email: email, password: password, nickname: nickname, tell: tell)
                    .catch { _ in
                        return Single.never()
                    }
            }
            .subscribe(onNext: { [weak self] userResponse in
                self?.responseRelay.accept(userResponse)
            })
            .disposed(by: disposeBag)
            
        
        return Output(signUpButtonEnabled: isValidTextRelay.asDriver(), signUpResponse: responseRelay.asSignal())
    } // closed transform
    
} // closed SignUpViewModel
