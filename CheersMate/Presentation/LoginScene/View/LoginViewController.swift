//
//  ViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/15/24.
//

import UIKit
import RxSwift
import RxCocoa

final public class LoginViewController: UIViewController {

    private var loginView = LoginView()
    private let viewModel: LoginViewModelProtocol
    private let disposeBag = DisposeBag()
    
    // init
    public init (viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // loadView
    public override func loadView() {
        self.view = loginView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupNavi()
        bindView()
        bindViewModel()
        setupTextFields()
    }
    
    // setupNavi
    private func setupNavi() {
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainTextColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // 바인드 뷰
    private func bindView() {
        // controlEvent는 에러를 방출하지 않고, 메인 스레드에서 동작
        // 회원가입 버튼이 클릭됬을 때 화면 전환
        loginView.signUpButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                let userNT = UserNetwork(manager: UserNetworkManager())
                let userRP = UserRepository(network: userNT)
                let userUC = UserUseCase(repository: userRP)
                let signUpVM = SignUpViewModel(useCase: userUC)
                let signUpVC = SignUpViewController(viewModel: signUpVM)
                let modalNVC = UINavigationController(rootViewController: signUpVC)
                modalNVC.setupNaviBarAppearance()
                modalNVC.modalPresentationStyle = .fullScreen
                present(modalNVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        // 이메일 찾기 버튼이 클릭됬을 때 화면 전환
        loginView.emailSearchButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                let userNT = UserNetwork(manager: UserNetworkManager())
                let userRP = UserRepository(network: userNT)
                let userUC = UserUseCase(repository: userRP)
                let accountFinderVM = AccountFinderViewModel(useCase: userUC)
                let accountFinderVC = AccountFinderViewController(viewModel: accountFinderVM, viewType: .findEmail)
                self.navigationController?.pushViewController(accountFinderVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        // 비밀번호 찾기 버튼이 클릭됬을 때 화면 전환
        loginView.passwordSearchButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                let userNT = UserNetwork(manager: UserNetworkManager())
                let userRP = UserRepository(network: userNT)
                let userUC = UserUseCase(repository: userRP)
                let accountFinderVM = AccountFinderViewModel(useCase: userUC)
                let accountFinderVC = AccountFinderViewController(viewModel: accountFinderVM, viewType: .findPassword)
                self.navigationController?.pushViewController(accountFinderVC, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    // 바인드 뷰 모델
    private func bindViewModel() {
        let input = LoginViewModel.Input(
            // 이메일 주소 텍스트
            emailTextField: loginView.emailTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asObservable(),
            
            // 비밀번호 텍스트
            passwordTextField: loginView.passwordTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asObservable(),
            
            // 로그인 버튼 클릭 이벤트
            loginButtonTapped: loginView.loginButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.instance) // throttle로 중복 클릭 방지
                .asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        // 이메일 주소 정규식 검증 결과
        output.isValidEmail
            .bind(onNext: { [weak self] valid in
                self?.loginView.emailFeedbackLabel.isHidden = valid
            })
            .disposed(by: disposeBag)
        
        // 비밀번호 정규식 검증 결과
        output.isValidPassword
            .bind(onNext: { [weak self] valid in
                self?.loginView.passwordFeedbackLabel.isHidden = valid
            })
            .disposed(by: disposeBag)
        
        // 로그인 버튼 활성화
        output.isLoginButtonEnabled
            .bind(onNext: { [weak self] valid in
                guard let self = self else { return }
                loginView.loginButton.isEnabled = valid // 활성화 여부
                valid ? (loginView.loginButton.backgroundColor = .buttonAbleColor) : (loginView.loginButton.backgroundColor = .buttonDisableColor) // 배경색상
            })
            .disposed(by: disposeBag)
        
        // 로그인 성공
        output.loginSuccess
            .bind(onNext: { [weak self] _ in
                self?.changeRootViewController()
            })
            .disposed(by: disposeBag)
        
        // 로그인 실패
        output.loginFailure
            .bind(onNext: { [weak self] _ in
                let popUpVC = PopUpViewController(title: "로그인에 실패했어요", subTitle: "이메일 주소 또는 비밀번호를 확인 후\n다시 시도해주세요", closeType: .dismissSingleModal)
                self?.present(popUpVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        
        
    }

    // 로그인 버튼을 클릭했을 때 루트 뷰를 변경하여 메모리 최적화
    private func changeRootViewController() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.changeRootViewController()
    }
    
} // closed LoginViewController

// extension
extension LoginViewController {
    // 키보드가 올라왔을 때 툴바를 적용하고, 완료버튼을 누르면 키보드 내리기
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
    }
    
    // 완료버튼을 누르면 키보드 내리기
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }

} // closed Extension
