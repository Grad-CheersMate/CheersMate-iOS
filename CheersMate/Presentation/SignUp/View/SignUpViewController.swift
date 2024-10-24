//
//  SignUpViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/23/24.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupNavi()
        setupTextFields()
    }
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        self.navigationItem.title = "회원가입"
        // 라지 타이틀 활성화
        self.navigationController?.navigationBar.prefersLargeTitles = true
        // 라지 타이틀 폰트 설정
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.pretendard(size: 30, family: .SemiBold)]
    }
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
    }
    
    // MARK: - 완료버튼을 누르면 키보드 내리기
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    
}
