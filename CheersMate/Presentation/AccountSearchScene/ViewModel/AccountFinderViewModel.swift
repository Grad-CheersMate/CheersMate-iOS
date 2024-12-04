//
//  EmailSearchViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/4/24.
//

import Foundation
import RxSwift
import RxCocoa

// AccountSearchViewModelProtocol
public protocol AccountFinderViewModelProtocol {
    func transform(input: AccountFinderViewModel.Input) -> AccountFinderViewModel.Output
}

// AccountSearchViewModel
final public class AccountFinderViewModel: AccountFinderViewModelProtocol {
    private let useCase: UserUseCaseProtocol
    private let isValidNicknameOrEmailRelay = PublishRelay<Bool>() // 닉네임 또는 이메일 정규식 릴레이
    private let isValidTellRelay = PublishRelay<Bool>() // 휴대폰 번호 정규식 릴레이
    private let successRelay = PublishRelay<String>() // 계정 찾기 성공 릴레이
    private let failureRelay = PublishRelay<Void>() // 계정 찾기 실패 릴레이
    private let disposeBag: DisposeBag = DisposeBag()
    
    // init
    public init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
    
    // Input
    public struct Input {
        let nicknameOrEmailTextField: Observable<String> // 닉네임 또는 이메일 입력 문자열
        let tellTextField: Observable<String> // 휴대폰 번호 입력 문자열
        let findButtonTapped: Observable<Void> // 계정 찾기 버튼 클릭 이벤트
        let accountFindType: BehaviorSubject<AccountFindType> // 이메일 찾기와 비밀번호 찾기를 구분하기 위한 타입
    }
    
    // Output
    public struct Output {
        let isValidNicknameOrEmail: Observable<Bool> // 닉네임 또는 이메일 정규식 검증 결과
        let isValidTell: Observable<Bool> // 휴대폰 번호 정규식 검증 결과
        let isFindButtonEnabled: Observable<Bool> // 계정 찾기 버튼의 활성화 체크
        let accountFindSuccess: PublishRelay<String>
        let accountFindFailure: PublishRelay<Void>
    }
    
    // transform
    public func transform(input: Input) -> Output {
        // 사용자가 입력한 이메일 또는 닉네임 텍스트 값과 계정 찾기 타입
        Observable.combineLatest(input.nicknameOrEmailTextField, input.accountFindType)
            .subscribe(onNext: { [weak self] nicknameOrEmail, type in
                guard let self = self else { return }
                if type == .findPassword { // 비밀번호 찾기일 때
                    let result = useCase.isMatchingRegex(text: nicknameOrEmail, type: .email) // 이메일 주소 정규식 검증
                    isValidNicknameOrEmailRelay.accept(result) // 검증 결과 전달
                } else { // 이메일 찾기일 때
                    let result = useCase.isMatchingRegex(text: nicknameOrEmail, type: .nickname) // 닉네임 정규식 검증
                    isValidNicknameOrEmailRelay.accept(result) // 검증 결과 전달
                }
            })
            .disposed(by: disposeBag)
        
        // 사용자가 입력한 휴대폰 번호 텍스트 값
        input.tellTextField
            .subscribe(onNext: { [weak self] tell in
                guard let self = self else { return }
                let result = useCase.isMatchingRegex(text: tell, type: .tell) // 휴대폰 번호 정규식 검증
                isValidTellRelay.accept(result) // 검증 결과 전달
            })
            .disposed(by: disposeBag)
        
        // 사용자가 계정 찾기 버튼을 클릭했을 때 이벤트
        input.findButtonTapped
            .withLatestFrom(Observable.combineLatest(input.nicknameOrEmailTextField, input.tellTextField, input.accountFindType))
            .subscribe(onNext: { [weak self] nicknameOrEmail, tell, type in
                guard let self = self else { return }
                switch type {
                case .findEmail: // 이메일 주소 찾기일 때
                    requestFindEmail(user: User(email: nil, password: nil, nickname: nicknameOrEmail, tell: tell))
                case .findPassword: // 비밀번호 찾기일 때
                    requestFindPassword(user: User(email: nicknameOrEmail, password: nil, nickname: nil, tell: tell))
                }
            })
            .disposed(by: disposeBag)
        
        // 계정 찾기 버튼의 활성화 여부
        let isFindButtonEnabled = Observable.combineLatest(isValidNicknameOrEmailRelay, isValidTellRelay) { $0 && $1 }

        return Output(isValidNicknameOrEmail: isValidNicknameOrEmailRelay.asObservable(),
                      isValidTell: isValidTellRelay.asObservable(),
                      isFindButtonEnabled: isFindButtonEnabled,
                      accountFindSuccess: successRelay,
                      accountFindFailure: failureRelay)
    }
    
} // closed AccountSearchViewModel

// extension
extension AccountFinderViewModel {
    // 이메일 주소 찾기 서버에 요청
    private func requestFindEmail(user: User) {
        useCase.findEmail(nickname: user.nickname!, tell: user.tell!)
            .subscribe { [weak self] res in
                if res.result && res.httpCode == 200 {
                    guard let email = res.user?.email else { return }
                    self?.successRelay.accept(email) // 찾은 이메일 주소를 전달
                }
            } onFailure: { [weak self] error in
                self?.failureRelay.accept(()) // 해당되는 이메일 주소가 없음
            }
            .disposed(by: disposeBag)
    }
    
    // 비밀번호 찾기 서버에 요청
    private func requestFindPassword(user: User) {
        useCase.findPassword(email: user.email!, tell: user.tell!)
            .subscribe { [weak self] res in
                if res.result && res.httpCode == 200 {
                    guard let password = res.user?.password else { return }
                    self?.successRelay.accept(password) // 임시 비밀번호를 전달
                }
            } onFailure: { [weak self] error in
                self?.failureRelay.accept(()) // 해당되는 이메일 주소가 없음
            }
            .disposed(by: disposeBag)
    }
}
