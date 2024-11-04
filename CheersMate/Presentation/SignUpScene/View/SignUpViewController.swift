//
//  SignUpViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/23/24.
//

import UIKit
import RxSwift
import RxCocoa

final public class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    private let viewModel: SignUpViewModelProtocol
    private let disposeBag = DisposeBag()
    private let naviTitle: String
    
    public override func loadView() {
        self.view = signUpView
    } // closed loadView
    
    public init(viewModel: SignUpViewModelProtocol, title: String) {
        self.naviTitle = title
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    } // closed init
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed required init
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupNavi()
        setupTextFields()
        bindView()
        bindViewModel()
    } // closed viewDidLoad
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        self.navigationItem.title = naviTitle
    } // closed setupNavi
    
    // MARK: - 키보드가 올라왔을 때 툴바를 적용하고, 완료버튼을 누르면 키보드 내리기
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
    } // closed setupTextFields
    
    // MARK: - 바인드 뷰
    private func bindView() {
        // 이메일 텍스트필드의 editing 여부에 따른 언더라인 색상 설정
        bindTextFieldEditing(signUpView.emailTextField, underline: signUpView.emailUnderLine)
        // 비밀번호 텍스트필드의 editing 여부에 따른 언더라인 색상 설정
        bindTextFieldEditing(signUpView.passwordTextField, underline: signUpView.passwordUnderLine)
        // 닉네임 텍스트필드의 editing 여부에 따른 언더라인 색상 설정
        bindTextFieldEditing(signUpView.nickNameTextField, underline: signUpView.nickNameUnderLine)
        // 전화번호 텍스트필드의 editing 여부에 따른 언더라인 색상 설정
        bindTextFieldEditing(signUpView.tellTextField, underline: signUpView.tellUnderLine)
    } // closed bindView
    
    // MARK: - 텍스트필드의 입력 시작, 종료 여부에 따른 언더라인 색상 변경
    private func bindTextFieldEditing(_ textField: UITextField, underline: UIView) {
        PublishRelay
            .merge(textField.rx.controlEvent(.editingDidBegin).map { true }, // 편집 시작
                   textField.rx.controlEvent(.editingDidEnd).map { false }) // 편집 종료
            .bind(onNext: { $0 ? (underline.backgroundColor = .mainColor) : (underline.backgroundColor = .systemGray5) })
            .disposed(by: disposeBag)
    } // closed bindTextFieldEditing
    
    // MARK: - 바인드 뷰 모델
    private func bindViewModel() {
        let input = SignUpViewModel.Input(
            // 이메일 텍스트를 뷰 모델로 전달
            emailTextField: signUpView.emailTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: ""),
            
            // 비밀번호 텍스트를 뷰 모델로 전달
            passwordTextField: signUpView.passwordTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: ""),
            
            // 닉네임 텍스트를 뷰 모델로 전달
            nicknameTextField: signUpView.nickNameTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: ""),
            
            // 전화번호 텍스트를 뷰 모델로 전달
            tellTextField: signUpView.tellTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: ""),
            
            // 회원가입 버튼 클릭 이벤트를 뷰 모델로 전달
            signUpButtonTapped: signUpView.signUpButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.signUpButtonEnabled
            .drive(onNext: { [weak self] valid in
                // 로그인 버튼의 활성화를 valid에 따라서 설정
                self?.signUpView.signUpButton.isEnabled = valid
                // 활성화에 따른 로그인 버튼의 색상 설정
                valid ? (self?.signUpView.signUpButton.backgroundColor = .mainColor) : (self?.signUpView.signUpButton.backgroundColor = .systemGray4)
            })
            .disposed(by: disposeBag)
        
        output.signUpResponse
            .emit { [weak self] userResponse in
                if userResponse.result == 1 {
                    self?.popUpAlert()
                }
            }
            .disposed(by: disposeBag)
    } // closed bindViewModel
    
    // 회원가입 버튼 클릭 시 나타나는 팝업 창
    private func popUpAlert() {
        let alert = UIAlertController(title: "회원가입 완료", message: "로그인하여 서비스를 이용해보세요!", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(success)
        present(alert, animated: true)
    }

} // closed Class


// MARK: - extension
extension SignUpViewController {
    // MARK: - 완료버튼을 누르면 키보드 내리기
    @objc public func doneButtonTapped() {
        view.endEditing(true)
    } // closed doneButtonTapped
    
} // closed extension
