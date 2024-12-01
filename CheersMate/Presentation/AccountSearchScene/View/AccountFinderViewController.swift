//
//  SearchingEmailViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit
import RxSwift
import RxCocoa

final public class AccountFinderViewController: UIViewController {
    
    private let accountFinderView: AccountFinderView
    private let accountFindType: AccountFindType // 이메일 찾기 또는 비밀번호 찾기
    private let viewModel: AccountSearchViewModelProtocol
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = accountFinderView
    }
    
    // init
    public init(viewModel: AccountSearchViewModelProtocol, accountFindType: AccountFindType) {
        self.accountFinderView = AccountFinderView(type: accountFindType)
        self.viewModel = viewModel
        self.accountFindType = accountFindType
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupNavi()
        setupTextFields()
        bindView()
        bindViewModel()
    }
    
    // 네비게이션 설정
    private func setupNavi() {
        self.title = accountFindType.title
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainNavyColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // 키보드가 올라왔을 때 툴바를 적용하고, 완료버튼을 누르면 키보드 내리기
    private func setupTextFields() {
        [accountFinderView.userInfoTextField, accountFinderView.tellTextField]
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
    
    // 바인드 뷰
    private func bindView() {
    }
    
    // 바인드 뷰 모델
    private func bindViewModel() {
//        let input = AccountSearchViewModel.Input(
//            // 닉네임 또는 이메일 텍스트를 뷰 모델로 전달
//            contactTextField:
//                accountFinderView.userInfoTextField.rx.text
//                .orEmpty
//                .distinctUntilChanged()
//                .asDriver(onErrorJustReturn: ""),
//            
//            // 전화번호 텍스트를 뷰 모델로 전달
//            tellTextField:
//                accountFinderView.tellTextField.rx.text
//                .orEmpty
//                .distinctUntilChanged()
//                .asDriver(onErrorJustReturn: ""),
//            
//            // 이메일 또는 비밀번호 찾기 버튼 클릭 이벤트를 뷰 모델로 전달
//            contactSearchButtonTapped: accountFinderView.findButton.rx.tap,
//            
//            viewType: viewType)
        
//        let output = viewModel.transform(input: input)
        
//        output.contactSearchButtonEnabled
//            .drive(onNext: { [weak self] valid in
//                // 이메일 또는 비밀번호 찾기 버튼의 활성화를 valid에 따라서 설정
//                self?.accountFinderView.findButton.isEnabled = valid
//                // 활성화에 따른 이메일 또는 비밀번호 찾기 버튼의 색상 설정
//                valid ? (self?.accountFinderView.findButton.backgroundColor = .mainColor) : (self?.accountFinderView.findButton.backgroundColor = .systemGray4)
//            })
//            .disposed(by: disposeBag)
        
//        output.contactSearchResponse
//            .emit { [weak self] userResponse in
//                let accountSearchResultVC = AccountSearchResultViewController(viewType: self!.viewType, outcome: .success)
//                accountSearchResultVC.modalPresentationStyle = .fullScreen
//                self?.present(accountSearchResultVC, animated: true)}
//            .disposed(by: disposeBag)
//        
//        output.contactSearchError
//            .emit { [weak self] _ in
//                let accountSearchResultVC = AccountSearchResultViewController(viewType: self!.viewType, outcome: .failure)
//                accountSearchResultVC.modalPresentationStyle = .fullScreen
//                self?.present(accountSearchResultVC, animated: true)}
//            .disposed(by: disposeBag)
        
    }
    
} // closed AccountFinderViewController


// extension 설정
extension AccountFinderViewController {
    // 완료버튼을 누르면 키보드 내리기
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}
