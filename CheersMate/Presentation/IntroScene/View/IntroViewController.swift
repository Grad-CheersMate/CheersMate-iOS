//
//  IntroViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/30/24.
//

import UIKit
import RxSwift
import RxCocoa

public final class IntroViewController: UIViewController {
    
    private let introView = IntroView()
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = introView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        bindView()
    }
    
    // setupNavi
    private func setupNavi() {
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainNavyColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // bindView
    private func bindView() {
        introView.emailLoginButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                // Data Layer
                let userNet = UserNetwork(manager: UserNetworkManager())
                let userRP = UserRepository(network: userNet)
                // Domain Layer
                let userUC = UserUseCase(repository: userRP)
                let loginVM = LoginViewModel(useCase: userUC)
                // Presentation Layer
                let loginVC = LoginViewController(viewModel: loginVM)
                self?.navigationController?.pushViewController(loginVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    
} // closed IntroViewController
