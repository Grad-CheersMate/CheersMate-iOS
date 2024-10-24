//
//  EmailSearchSuccessViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit
import RxSwift
import RxCocoa

final class EmailSearchSuccessViewController: UIViewController {
    
    private let emailSearchSuccessView = EmailSearchSuccessView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = emailSearchSuccessView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindView()
    }
    
    // MARK: - 뷰 바인드
    private func bindView() {
        // MARK: - 이메일 찾기에 성공하고, 로그인 하기 버튼을 눌렀을 때 초기 로그인 화면으로 이동
        emailSearchSuccessView.logInButton.rx.tap
            .bind { [weak self] _ in
                // 이전 화면을 presentingViewController를 통해 불러오고 UINavigationController로 다운 캐스팅
                guard let presentingViewController = self?.presentingViewController as? UINavigationController else { return }
                // 루트 뷰를 제외한 모든 컨트롤러를 네비게이션 스택에서 pop
                presentingViewController.popToRootViewController(animated: true)
                // 현재 화면 제거
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }

}
