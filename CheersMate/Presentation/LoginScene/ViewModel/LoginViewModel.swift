//
//  LoginViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 10/20/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModelProtocol {
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output
}

final class LoginViewModel: LoginViewModelProtocol {
    
    private let disposeBag: DisposeBag = DisposeBag()

    
//    init(usecase: LoginUsecaseProtocol) {
//        self.usecase = usecase
//    }
    
    struct Input {
        let emailTextField: Driver<String>
        let passwordTextField: Driver<String>
    } // close Input
    
    struct Output {
        let loginButtonEnabled: Driver<Bool>
    } // close Output
    
    func transform(input: Input) -> Output {
        // 이메일 텍스트 필드로부터 텍스트를 전달받고 유효성 검사 실시
        let emailText = input.emailTextField
            .map { [weak self] text in
                self?.isValidEmail(text) ?? false
            }
        
        // 비밀번호 텍스트 필드로부터 텍스트를 전달받고 유효성 검사 실시
        let passwordText = input.passwordTextField
            .map { [weak self] text in
                self?.isValidPassword(text) ?? false
            }
        
        // 이메일 및 비밀번호의 입력이 모두 유효할 시 로그인 버튼 활성화
        let loginButtonEnabled = Observable.combineLatest(emailText.asObservable(), passwordText.asObservable())
            .map { $0 && $1 }
            .asDriver(onErrorJustReturn: false)
        
        
        return Output(loginButtonEnabled: loginButtonEnabled)
    } // closed transform
    
    
} // closed Class

// MARK: - extension
extension LoginViewModel {
    // 이메일 유효성 검사
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    // 비밀번호 유효성 검사 - 소문자, 숫자 하나 이상 포함 및 길이 8자 이상
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9]).{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with: password)
    }
}
