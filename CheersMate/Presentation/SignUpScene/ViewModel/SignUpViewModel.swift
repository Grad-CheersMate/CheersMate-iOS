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
    private let useCase: UserUseCaseProtocol // 유스케이스
    private let isValidEmailRelay = PublishRelay<Bool>() // 이메일 정규식 릴레이
    private let isValidPasswordRelay = PublishRelay<Bool>() // 이메일 정규식 릴레이
    private let isValidTellRelay = PublishRelay<Bool>() // 이메일 정규식 릴레이
    private let responseRelay = PublishRelay<UserResponse>()
    private let disposeBag: DisposeBag = DisposeBag()
    
    // init
    public init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
    
    // Input
    public struct Input {
        let emailTextField: Observable<String> // 이메일 입력 문자열
        let passwordTextField: Observable<String> // 비밀번호 입력 문자열
        let tellTextField: Observable<String> // 전화번호 입력 문자열
        let signUpButtonTapped: Observable<Void> // 회원가입 버튼 클릭 이벤트
    }
    
    // Output
    public struct Output {
        let isValidEmail: Observable<Bool>
        let isValidPassword: Observable<Bool>
        let isValidTell: Observable<Bool>
        let isSignUpButtonEnabled: Observable<Bool> // 회원가입 버튼의 활성화 체크
//        let signUpResponse: Signal<UserResponse> // 로그인 요청에 관한 응답
    }
    
    // transform
    public func transform(input: Input) -> Output {
        
        // 사용자가 입력한 이메일 텍스트 값
        input.emailTextField
            .subscribe(onNext: { [weak self] email in
                guard let self = self else { return }
                let result = useCase.isMatchingRegex(text: email, type: .email)
                isValidEmailRelay.accept(result)
            })
            .disposed(by: disposeBag)
        
        // 사용자가 입력한 비밀번호 텍스트 값
        input.passwordTextField
            .subscribe(onNext: { [weak self] password in
                guard let self = self else { return }
                let result = useCase.isMatchingRegex(text: password, type: .password)
                isValidPasswordRelay.accept(result)
            })
            .disposed(by: disposeBag)
        
        // 사용자가 입력한 휴대폰 번호 텍스트 값
        input.tellTextField
            .subscribe(onNext: { [weak self] tell in
                guard let self = self else { return }
                let result = useCase.isMatchingRegex(text: tell, type: .tell)
                isValidTellRelay.accept(result)
            })
            .disposed(by: disposeBag)
        
        let isEnableSignUpButton = Observable.combineLatest(isValidEmailRelay, isValidPasswordRelay, isValidTellRelay) { $0 && $1 && $2 }
        
        return Output(isValidEmail: isValidEmailRelay.asObservable(), isValidPassword: isValidPasswordRelay.asObservable(), isValidTell: isValidTellRelay.asObservable(), isSignUpButtonEnabled: isEnableSignUpButton)
    }
    
} // closed SignUpViewModel
