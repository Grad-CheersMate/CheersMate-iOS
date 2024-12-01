//
//  EmailSearchViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/4/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol AccountSearchViewModelProtocol {
    func transform(input: AccountSearchViewModel.Input) -> AccountSearchViewModel.Output
}

final public class AccountSearchViewModel: AccountSearchViewModelProtocol {
    private let useCase: UserUseCaseProtocol
    private let isValidTextRelay = BehaviorRelay<Bool>(value: false) // 이메일, 비밀번호, 전화번호가 모두 유효한지 체크
    private let responseRelay = PublishRelay<UserResponse>()
    private let errorRelay = PublishRelay<Error>()
    private let disposeBag: DisposeBag = DisposeBag()
    
    public init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    } // closed init
    
    public struct Input {
        let contactTextField: Driver<String> // 닉네임 또는 이메일 입력 문자열
        let tellTextField: Driver<String> // 전화번호 입력 문자열
        let contactSearchButtonTapped: ControlEvent<Void> // 닉네임 또는 이메일 찾기 버튼 클릭 이벤트
        let viewType: AccountFindType // 이메일 찾기와 비밀번호 찾기를 구분하기 위한 타입
    } // closed Input
    
    public struct Output {
        let contactSearchButtonEnabled: Driver<Bool> // 닉네임 또는 이메일 찾기 버튼의 활성화
        let contactSearchResponse: Signal<UserResponse> // 닉네임 또는 이메일 찾기 버튼 요청 응답
        let contactSearchError: Signal<Error> // 닉네임 또는 이메일 찾기 버튼 요청 에러
    } // closed Output
    
    public func transform(input: Input) -> Output {
        
        Driver.combineLatest(
            input.contactTextField,
            input.tellTextField)
        .map { [weak self] contact, tell in
            switch input.viewType {
            case .email:
                (self?.useCase.isMatchingRegex(text: tell, type: .tell) ?? false)
            case .password:
                (self?.useCase.isMatchingRegex(text: contact, type: .email) ?? false) &&
                (self?.useCase.isMatchingRegex(text: tell, type: .tell) ?? false)
            }
        }
        .drive(isValidTextRelay)
        .disposed(by: disposeBag)
        
        // flatMapLatest는 내부 옵저버블을 구독하는데 이때 에러가 발생하면 스트림이 끊어지니 주의할 것!
        input.contactSearchButtonTapped
            .withLatestFrom(Observable.combineLatest(input.contactTextField.asObservable(),
                                                     input.tellTextField.asObservable(),
                                                     isValidTextRelay))
            .filter { $2 }
            .flatMapLatest { [weak self] contact, tell, _ -> Single<UserResponse> in
                guard let self = self else { return Single.never() }
                switch input.viewType {
                case .email:
                    return self.useCase.searchEmail(nickname: contact, tell: tell)
                        .catch { [weak self] err in
                            self?.errorRelay.accept(err)
                            return Single.never()
                        }
                case .password:
                    return self.useCase.searchPassword(email: contact, tell: tell)
                        .catch { [weak self] err in
                            self?.errorRelay.accept(err)
                            return Single.never()
                        }
                }
            }
            .subscribe( onNext: { [weak self] userResponse in
                self?.responseRelay.accept(userResponse)})
            .disposed(by: disposeBag)
        
        
        return Output(contactSearchButtonEnabled: isValidTextRelay.asDriver(), contactSearchResponse: responseRelay.asSignal(), contactSearchError: errorRelay.asSignal())
    } // closed transform
    
} // closed SignUpViewModel
