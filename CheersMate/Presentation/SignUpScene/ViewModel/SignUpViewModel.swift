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
    private let isValidPasswordRelay = PublishRelay<Bool>() // 비밀번호 정규식 릴레이
    private let isValidNicknameRelay = PublishRelay<Bool>() // 닉네임 정규식 릴레이
    private let isValidTellRelay = PublishRelay<Bool>() // 휴대폰 번호 정규식 릴레이
    private let successRelay = PublishRelay<Void>() // 회원가입 성공 릴레이
    private let failureRelay = PublishRelay<Void>() // 회원가입 실패 릴레이
    private let disposeBag: DisposeBag = DisposeBag()
    
    // init
    public init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
    
    // Input
    public struct Input {
        let emailTextField: Observable<String> // 이메일 입력 문자열
        let passwordTextField: Observable<String> // 비밀번호 입력 문자열
        let nicknameTextField: Observable<String> // 닉네임 입력 문자열
        let tellTextField: Observable<String> // 전화번호 입력 문자열
        let signUpButtonTapped: Observable<Void> // 회원가입 버튼 클릭 이벤트
    }
    
    // Output
    public struct Output {
        let isValidEmail: Observable<Bool> // 이메일 정규식 검증 결과
        let isValidPassword: Observable<Bool> // 비밀번호 정규식 검증 결과
        let isValidNickname: Observable<Bool> // 닉네임 정규식 검증 결과
        let isValidTell: Observable<Bool> // 휴대폰 번호 정규식 검증 결과
        let isSignUpButtonEnabled: Observable<Bool> // 회원가입 버튼의 활성화 체크
        let signUpSuccess: PublishRelay<Void> // 회원가입 성공
        let signUpFailure: PublishRelay<Void> // 회원가입 실패
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
        
        // 사용자가 입력한 닉네임 텍스트 값
        input.nicknameTextField
            .subscribe(onNext: { [weak self] nickname in
                guard let self = self else { return }
                let result = useCase.isMatchingRegex(text: nickname, type: .nickname) // 닉네임 정규식 검증
                isValidNicknameRelay.accept(result) // 검증 결과 전달

            })
            .disposed(by: disposeBag)
        
        // 사용자가 입력한 휴대폰 번호 텍스트 값
        input.tellTextField
            .subscribe(onNext: { [weak self] tell in
                guard let self = self else { return }
                let result = useCase.isMatchingRegex(text: tell, type: .tell) // 휴대폰 전호 정규식 검증
                isValidTellRelay.accept(result) // 검증 결과 전달

            })
            .disposed(by: disposeBag)
        
        // 사용자가 회원가입 버튼을 클릭했을 때 이벤트
        input.signUpButtonTapped
            .withLatestFrom(Observable.combineLatest(input.emailTextField, input.passwordTextField, input.nicknameTextField, input.tellTextField)) // 클릭이 들어올 때 combineLatest로 종합
            .subscribe(onNext: { [weak self] email, password, nickname, tell in
                guard let self = self else { return }
                requestSignUp(user: User(email: email, password: password, nickname: nickname, tell: tell))
            })
            .disposed(by: disposeBag)
        
        // 회원가입 버튼의 활성화 여부
        let isSignUpButtonEnable = Observable.combineLatest(isValidEmailRelay, isValidPasswordRelay, isValidNicknameRelay, isValidTellRelay) { $0 && $1 && $2 && $3 }
        
        return Output(isValidEmail: isValidEmailRelay.asObservable(),
                      isValidPassword: isValidPasswordRelay.asObservable(),
                      isValidNickname: isValidNicknameRelay.asObservable(),
                      isValidTell: isValidTellRelay.asObservable(),
                      isSignUpButtonEnabled: isSignUpButtonEnable,
                      signUpSuccess: successRelay,
                      signUpFailure: failureRelay)
    }
    
} // closed SignUpViewModel

// extension
extension SignUpViewModel {
    // 회원가입 서버에 요청
    private func requestSignUp(user: User) {
        useCase.signUp(user: user)
            .subscribe { [weak self] res in
                if res.result && res.httpCode == 200 {
                    self?.successRelay.accept(()) // 성공
                }
            } onFailure: { [weak self] error in
                self?.failureRelay.accept(()) // 실패
            }
            .disposed(by: disposeBag)
    }
    
}
