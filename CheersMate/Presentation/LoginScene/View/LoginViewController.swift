//
//  ViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/15/24.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    private var loginView = LoginView()
    private let viewModel: LoginViewModelProtocol
    private let disposeBag = DisposeBag()
    
    init (viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupNavi()
        bindView()
        bindViewModel()
        setupTextFields()
    }
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    } // closed setupNavi
    
    // MARK: - 바인드 뷰
    private func bindView() {
        // MARK: - 회원가입 버튼이 클릭됬을 때 화면 전환
        // controlEvent는 에러를 방출하지 않고, 메인 스레드에서 동작
        loginView.signUpButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.pushViewController(SignUpViewController(title: ""), animated: true)
            }
            .disposed(by: disposeBag)
        
        // MARK: - 이메일 찾기 버튼이 클릭됬을 때 화면 전환
        loginView.emailSearchButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.pushViewController(EmailSearchViewController(naviTitle: "이메일 찾기"), animated: true)
            }
            .disposed(by: disposeBag)
        
        // MARK: - 비밀번호 찾기 버튼이 클릭됬을 때 화면 전환
        loginView.passwordSearchButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.pushViewController(PasswordSearchViewController(naviTitle: "비밀번호 찾기"), animated: true)
            }
            .disposed(by: disposeBag)
        
        // MARK: - 로그인 버튼이 클릭됬을 때 화면 전환
        loginView.loginButton.rx.tap
            .bind { [weak self] _ in
                let nt = UserNetwork(manager: UserNetworkManager())
                guard let email = self?.loginView.emailTextField.text, let password = self?.loginView.passwordTextField.text else { return }
                nt.login(email: email, password: password) { response in
                    switch response {
                    case .success(let res):
                        print(res)
                        self?.changeRootViewController()
                    case .failure(let err):
                        print(err)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        // MARK: - 이메일 텍스트필드의 editing 여부에 따른 언더라인 색상 설정
        PublishRelay
            .merge(loginView.emailTextField.rx.controlEvent(.editingDidBegin).map { true }, // 편집 시작
                   loginView.emailTextField.rx.controlEvent(.editingDidEnd).map { false }) // 편집 종료
            .bind(onNext: { [weak self] isEditing in
                isEditing ? (self?.loginView.emailUnderLine.backgroundColor = .mainColor) : (self?.loginView.emailUnderLine.backgroundColor = .systemGray5)
            })
            .disposed(by: disposeBag)
        
        // MARK: - 비밀번호 텍스트필드의 editing 여부에 따른 언더라인 색상 설정
        PublishRelay
            .merge(loginView.passwordTextField.rx.controlEvent(.editingDidBegin).map { true }, // 편집 시작
                   loginView.passwordTextField.rx.controlEvent(.editingDidEnd).map { false }) // 편집 종료
            .bind(onNext: { [weak self] isEditing in
                isEditing ? (self?.loginView.passwordUnderLine.backgroundColor = .mainColor) : (self?.loginView.passwordUnderLine.backgroundColor = .systemGray5)
            })
            .disposed(by: disposeBag)
        
    } // closed bindView
    
    private func bindViewModel() {
        let input = LoginViewModel.Input(
            emailTextField: loginView.emailTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: ""),
            passwordTextField: loginView.passwordTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: "")
        )
        
        let output = viewModel.transform(input: input)
        
        output.loginButtonEnabled
            .drive(onNext: {[weak self] valid in
                self?.loginView.loginButton.isEnabled = valid
                valid
                ? (self?.loginView.loginButton.backgroundColor = .mainColor)
                : (self?.loginView.loginButton.backgroundColor = .systemGray4)
            })
            .disposed(by: disposeBag)
        
        
    }
    
    // MARK: - 키보드가 올라왔을 때 툴바를 적용하고, 완료버튼을 누르면 키보드 내리기
    private func setupTextFields() {
        [loginView.emailTextField, loginView.passwordTextField]
            .forEach {
                $0.addDoneToolbar(target: self, action: #selector(doneButtonTapped)) // 툴바 적용
                $0.rx.controlEvent(.editingDidEndOnExit) // return 클릭 시
                    .bind(onNext: { [weak self] _ in
                        self?.doneButtonTapped()
                    })
                    .disposed(by: disposeBag)
            }
    } // closed setupTextFields
    
    // MARK: - 로그인 버튼을 클릭했을 때 루트 뷰를 변경하여 메모리 최적화
    private func changeRootViewController() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.changeRootViewController()
    } // closed changeRootViewController
    
} // closed Class

// MARK: - @objc 설정
extension LoginViewController {
    // MARK: - 완료버튼을 누르면 키보드 내리기
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
} // closed Extension
