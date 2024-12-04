//
//  SignUpViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/23/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

final public class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    private let viewModel: SignUpViewModelProtocol
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = signUpView
    }
    
    // init
    public init(viewModel: SignUpViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupNavi()
        setupTextFields()
        bindView()
        bindViewModel()
    }
    
    // 네비게이션 설정
    private func setupNavi() {
        self.title = "회원가입"
        self.navigationItem.rightBarButtonItem = signUpView.rightBarButtonItem // 뒤로가기 버튼 등록
    }
    
    // 바인드 뷰
    private func bindView() {
        // 사용자가 x 버튼을 클릭했을 때
        signUpView.rightBarCrossButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true) // 로그인 화면으로 돌아가기
            })
            .disposed(by: disposeBag)
        
        // 키보드가 올라왔을 때
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardHeight in
                guard let self = self else { return }
                
                // 키보드 높이에 따라 contentInset 조정
                let safeAreaBottom = self.view.safeAreaInsets.bottom
                let inset = keyboardHeight - safeAreaBottom
                signUpView.scrollView.contentInset.bottom = max(inset, 0)
                signUpView.scrollView.scrollIndicatorInsets.bottom = max(inset, 0)
                
            })
            .disposed(by: disposeBag)
        
        // 텍스트 필드가 선택되었을 때 가려지지 않도록 스크롤
        Observable.merge(
            signUpView.emailTextField.rx.controlEvent(.editingDidBegin)
                .asObservable()
                .map { self.signUpView.emailTextField },
            signUpView.passwordTextField.rx.controlEvent(.editingDidBegin)
                .asObservable()
                .map { self.signUpView.passwordTextField },
            signUpView.nickNameTextField.rx.controlEvent(.editingDidBegin)
                .asObservable()
                .map { self.signUpView.nickNameTextField },
            signUpView.tellTextField.rx.controlEvent(.editingDidBegin)
                .asObservable()
                .map { self.signUpView.tellTextField }
        )
        .subscribe(onNext: { [weak self] textField in
            guard let self = self else { return }
            let frame = textField.convert(textField.bounds, to: signUpView.scrollView)
            signUpView.scrollView.scrollRectToVisible(frame, animated: true)
        })
        .disposed(by: disposeBag)
    }
    
    // 바인드 뷰 모델
    private func bindViewModel() {
        let input = SignUpViewModel.Input(
            // 이메일 텍스트
            emailTextField: signUpView.emailTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asObservable(),
            
            // 비밀번호 텍스트
            passwordTextField: signUpView.passwordTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asObservable(),
            
            // 닉네임 텍스트
            nicknameTextField: signUpView.nickNameTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asObservable(),
            
            // 휴대폰 번호 텍스트
            tellTextField: signUpView.tellTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asObservable(),
            
            // 회원가입 버튼 클릭
            signUpButtonTapped: signUpView.signUpButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.instance) // throttle로 중복 클릭 방지
                .asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        // 이메일 주소 정규식 검증 결과
        output.isValidEmail
            .bind(onNext: { [weak self] valid in
                self?.signUpView.emailFeedbackLabel.isHidden = valid
            })
            .disposed(by: disposeBag)
        
        // 비밀번호 정규식 검증 결과
        output.isValidPassword
            .bind(onNext: { [weak self] valid in
                self?.signUpView.passwordFeedbackLabel.isHidden = valid
            })
            .disposed(by: disposeBag)
        
        // 닉네임 정규식 검증 결과
        output.isValidNickname
            .bind(onNext: { [weak self] valid in
                print(valid)
                self?.signUpView.nicknameFeedbackLabel.isHidden = valid
            })
            .disposed(by: disposeBag)
        
        // 휴대폰 번호 정규식 검증 결과
        output.isValidTell
            .bind(onNext: { [weak self] valid in
                self?.signUpView.tellFeedbackLabel.isHidden = valid
            })
            .disposed(by: disposeBag)
        
        // 회원가입 버튼 활성화
        output.isSignUpButtonEnabled
            .bind(onNext: { [weak self] valid in
                guard let self = self else { return }
                signUpView.signUpButton.isEnabled = valid
                valid ? (signUpView.signUpButton.backgroundColor = .buttonAbleColor) : (signUpView.signUpButton.backgroundColor = .buttonDisableColor)
            })
            .disposed(by: disposeBag)
        
        // 회원가입 성공
        output.signUpSuccess
            .bind(onNext: { [weak self] _ in
                let popUpVC = PopUpViewController(title: "회원가입에 성공했어요", subTitle: "환영합니다! 🎉 로그인 후 CheersMate를 이용할 수 있어요", closeType: .dismissNestedModals)
                self?.present(popUpVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        // 회원가입 실패
        output.signUpFailure
            .bind(onNext: { [weak self] _ in
                let popUpVC = PopUpViewController(title: "회원가입에 실패했어요", subTitle: "해당 정보는 이미 사용 중이에요. 다른 이메일 주소나 닉네임으로 다시 시도해주세요", closeType: .dismissSingleModal)
                self?.present(popUpVC, animated: true)
            })
            .disposed(by: disposeBag)
    }

} // closed SignUpViewController


// extension
extension SignUpViewController {
    // 키보드에 툴바를 적용하고, 완료버튼 클릭 시 키보드 내리기
    private func setupTextFields() {
        [signUpView.emailTextField, signUpView.passwordTextField, signUpView.nickNameTextField, signUpView.tellTextField]
            .forEach {
                // 툴바 등록
                $0.addDoneToolbar(target: self, action: #selector(doneButtonTapped))
                // 키보드에서 리턴 버튼을 클릭했을 때
                $0.rx.controlEvent(.editingDidEndOnExit)
                    .bind(onNext: { [weak self] _ in
                        self?.doneButtonTapped()
                    })
                    .disposed(by: disposeBag)
            }
    }
    
    // 완료버튼을 누르면 키보드 내리기
    @objc public func doneButtonTapped() {
        view.endEditing(true)
    }
    
} // closed extension
