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
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    
}
