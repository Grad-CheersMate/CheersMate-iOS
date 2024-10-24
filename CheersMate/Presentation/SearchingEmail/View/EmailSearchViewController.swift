//
//  SearchingEmailViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit
import RxSwift
import RxCocoa

final class EmailSearchViewController: UIViewController {
    
    private let emailSearchView = EmailSearchView()
    private let disposeBag = DisposeBag()
    private let naviTitle: String
    
    override func loadView() {
        self.view = emailSearchView
    }
    
    init(naviTitle: String) {
        self.naviTitle = naviTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupNavi()
        bindView()
    }
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        self.navigationItem.title = naviTitle
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    // MARK: - 뷰 바인드
    private func bindView() {
        // MARK: - 키보드가 올라왔을 때 툴바를 적용하고, 완료버튼을 누르면 키보드 내리기
        [emailSearchView.nickNameTextField, emailSearchView.tellTextField]
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
        // MARK: - 닉네임과 휴대폰 번호를 입력한 후 이메일 찾기 버튼을 눌렀을 때 화면 전환
        emailSearchView.emailSearchButton.rx.tap
            .bind { [weak self] _ in
                let EmailSearchSuccessViewController = EmailSearchSuccessViewController()
                EmailSearchSuccessViewController.modalPresentationStyle = .fullScreen
                self?.present(EmailSearchSuccessViewController, animated: true)
                // 등록된 계정이 없을 때
                // self?.navigationController?.pushViewController(EmailSearchFailureViewController(naviTitle: ""), animated: true)
            }
            .disposed(by: disposeBag)
        
        
    } // closed bindView
     
    


} // closed Class

// MARK: - @objc 설정
extension EmailSearchViewController {
    // MARK: - 완료버튼을 누르면 키보드 내리기
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}
