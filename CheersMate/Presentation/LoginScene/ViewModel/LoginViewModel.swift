//
//  LoginViewModel.swift
//  CheersMate
//
//  Created by 7aeHoon on 3/4/25.
//

import Foundation
import RxSwift
import RxRelay

public protocol LoginViewModelProtocol {
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output
}

final public class LoginViewModel: LoginViewModelProtocol {
    
    // 사용자 유스케이스 프로토콜
    private let appleLoginRelay = PublishRelay<Void>()
    private let kakaoLoginRelay = PublishRelay<Void>()
    private let userUseCase: UserUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    // init
    public init(userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
    }
    
    // Input
    public struct Input {
        // 애플 로그인 버튼 클릭
        let appleLoginButtonTapped: Observable<Void>
        
        // 카카오 로그인 버튼 클릭
        let kakaoLoginButtonTapped: Observable<Void>
    }
    
    // Output
    public struct Output {
        // 애플 로그인 결과
        let appleLoginResult: PublishRelay<Void>
        
        // 카카오 로그인 결과
        let kakaoLoginResult: PublishRelay<Void>
    }
    
    // transform
    public func transform(input: Input) -> Output {
        // 애플 로그인 처리
        input.appleLoginButtonTapped
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.appleLoginRelay.accept(())
            }
            .disposed(by: disposeBag)

        // 카카오 로그인 처리
        input.kakaoLoginButtonTapped
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.kakaoLoginRelay.accept(())
            }
            .disposed(by: disposeBag)
        
        
        return Output(appleLoginResult: appleLoginRelay,
                      kakaoLoginResult: kakaoLoginRelay)
    }
    
} // LoginViewModel
