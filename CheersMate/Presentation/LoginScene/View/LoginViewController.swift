//
//  IntroViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/30/24.
//

import UIKit
import RxSwift
import RxCocoa

final public class LoginViewController: UIViewController {
    
    // 커스텀 로그인 뷰
    private let loginView = LoginView()
    private let viewModel: LoginViewModelProtocol
    private let disposeBag = DisposeBag()
    
    // init
    public init(viewModel: LoginViewModelProtocol) {
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
        bindView()
        bindViewModel()
    }
    
    // bindView
    private func bindView() {

    }
    
    // bindViewModel
    private func bindViewModel() {
        let input = LoginViewModel.Input(appleLoginButtonTapped: loginView.appleLoginButton.rx.controlEvent(.touchUpInside).asObservable(),
                                         kakaoLoginButtonTapped: loginView.kakaoLoginButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.appleLoginResult
            .withUnretained(self)
            .bind { (owner, _) in
                owner.changeRootViewController()
            }
            .disposed(by: disposeBag)
        
        output.kakaoLoginResult
            .bind {
                $0
            }.disposed(by: disposeBag)
    }
    
    // 로그인 버튼을 클릭했을 때 루트 뷰를 변경하여 메모리 최적화
    private func changeRootViewController() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.changeRootViewController()
    }
    
} // closed IntroViewController
