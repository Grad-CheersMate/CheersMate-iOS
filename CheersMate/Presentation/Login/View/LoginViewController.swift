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
    
    private let loginView = LoginView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupNavi()
        setupTextFields()
        signUpButtonTapped()
        searchingEmailButtonTapped()
    }
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // MARK: - 키보드가 올라왔을 때 툴바를 적용하고, 완료버튼을 누르면 키보드 내리기
    private func setupTextFields() {
        [loginView.emailTextField, loginView.passwordTextField]
            .forEach {
                $0.addDoneToolbar(target: self, action: #selector(doneButtonTapped))
                $0.rx.controlEvent(.editingDidEndOnExit)
                    .bind(onNext: { [weak self] _ in
                        self?.doneButtonTapped()
                    })
                    .disposed(by: disposeBag)
            }
    }
    // MARK: - 회원가입 버튼이 클릭됬을 때 화면 전환
    private func signUpButtonTapped() {
        // controlEvent는 에러를 방출하지 않고, 메인 스레드에서 동작
        loginView.signUpButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.pushViewController(SignUpViewController(title: ""), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - 이메일 찾기 버튼이 클릭됬을 때 화면 전환
    private func searchingEmailButtonTapped() {
        loginView.emailSearchButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.pushViewController(EmailSearchViewController(naviTitle: "이메일 찾기"), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - 완료버튼을 누르면 키보드 내리기
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
}
