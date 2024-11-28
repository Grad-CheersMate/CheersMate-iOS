//
//  SearchingEmailViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit
import RxSwift
import RxCocoa

final public class AccountSearchViewController: UIViewController {
    
    private let accountSearchView = AccountSearchView()
    private let viewType: ViewType
    private let naviTitle: String
    private let viewModel: AccountSearchViewModelProtocol
    private let disposeBag = DisposeBag()
    
    public override func loadView() {
        self.view = accountSearchView
    } // closed loadView
    
    public init(viewModel: AccountSearchViewModelProtocol, viewType: ViewType) {
        self.viewModel = viewModel
        self.viewType = viewType
        self.naviTitle = viewType.rawValue
        self.accountSearchView.configure(viewType: viewType)
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
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainNavyColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    } // closed setupNavi
    
    // MARK: - 키보드가 올라왔을 때 툴바를 적용하고, 완료버튼을 누르면 키보드 내리기
    private func setupTextFields() {
        [accountSearchView.contactTextField, accountSearchView.tellTextField]
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
    
    // MARK: - 텍스트필드의 입력 시작, 종료 여부에 따른 언더라인 색상 변경
    private func bindTextFieldEditing(_ textField: UITextField, underline: UIView) {
        PublishRelay
            .merge(textField.rx.controlEvent(.editingDidBegin).map { true }, // 편집 시작
                   textField.rx.controlEvent(.editingDidEnd).map { false }) // 편집 종료
            .bind(onNext: { $0 ? (underline.backgroundColor = .mainColor) : (underline.backgroundColor = .systemGray5) })
            .disposed(by: disposeBag)
    } // closed bindTextFieldEditing
    
    // MARK: - 뷰 바인드
    private func bindView() {
        // 닉네임 텍스트필드의 editing 여부에 따른 언더라인 색상 설정
        bindTextFieldEditing(accountSearchView.contactTextField, underline: accountSearchView.contactUnderLine)
        // 전화번호 텍스트필드의 editing 여부에 따른 언더라인 색상 설정
        bindTextFieldEditing(accountSearchView.tellTextField, underline: accountSearchView.tellUnderLine)
    } // closed bindView
    
    // MARK: - 바인드 뷰 모델
    private func bindViewModel() {
        let input = AccountSearchViewModel.Input(
            // 닉네임 또는 이메일 텍스트를 뷰 모델로 전달
            contactTextField:
                accountSearchView.contactTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: ""),
            
            // 전화번호 텍스트를 뷰 모델로 전달
            tellTextField:
                accountSearchView.tellTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: ""),
            
            // 이메일 또는 비밀번호 찾기 버튼 클릭 이벤트를 뷰 모델로 전달
            contactSearchButtonTapped: accountSearchView.contactSearchButton.rx.tap,
            
            viewType: viewType)
        
        let output = viewModel.transform(input: input)
        
        output.contactSearchButtonEnabled
            .drive(onNext: { [weak self] valid in
                // 이메일 또는 비밀번호 찾기 버튼의 활성화를 valid에 따라서 설정
                self?.accountSearchView.contactSearchButton.isEnabled = valid
                // 활성화에 따른 이메일 또는 비밀번호 찾기 버튼의 색상 설정
                valid ? (self?.accountSearchView.contactSearchButton.backgroundColor = .mainColor) : (self?.accountSearchView.contactSearchButton.backgroundColor = .systemGray4)
            })
            .disposed(by: disposeBag)
        
        output.contactSearchResponse
            .emit { [weak self] userResponse in
                let accountSearchResultVC = AccountSearchResultViewController(viewType: self!.viewType, outcome: .success)
                accountSearchResultVC.modalPresentationStyle = .fullScreen
                self?.present(accountSearchResultVC, animated: true)}
            .disposed(by: disposeBag)
        
        output.contactSearchError
            .emit { [weak self] _ in
                let accountSearchResultVC = AccountSearchResultViewController(viewType: self!.viewType, outcome: .failure)
                accountSearchResultVC.modalPresentationStyle = .fullScreen
                self?.present(accountSearchResultVC, animated: true)}
            .disposed(by: disposeBag)
        
    } // closed bindViewModel
    
} // closed Class

// MARK: - @objc 설정
extension AccountSearchViewController {
    // MARK: - 완료버튼을 누르면 키보드 내리기
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
} // closed loadView
