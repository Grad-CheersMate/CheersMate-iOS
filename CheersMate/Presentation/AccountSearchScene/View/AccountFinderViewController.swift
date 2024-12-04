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
    private let viewModel: AccountFinderViewModelProtocol
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = accountFinderView
    }
    
    // init
    public init(viewModel: AccountFinderViewModel, viewType: AccountFindType) {
        self.accountFinderView = AccountFinderView(type: viewType)
        self.viewModel = viewModel
        self.accountFindType = viewType
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
        backBarButtonItem.tintColor = .mainTextColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // 바인드 뷰
    private func bindView() {
    }
    
    // 바인드 뷰 모델
    private func bindViewModel() {
    
        let input = AccountFinderViewModel.Input(
            // 닉네임 또는 이메일 주소 텍스트
            nicknameOrEmailTextField: accountFinderView.nicknameOrEmailTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asObservable(),
            
            // 휴대폰 번호 텍스트
            tellTextField: accountFinderView.tellTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .asObservable(),
            
            // 계정 찾기 버튼 클릭
            findButtonTapped: accountFinderView.findButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.instance) // throttle로 1초 동안 중복 클릭 방지
                .asObservable(),
            
            // 계정 찾는 타입
            accountFindType: BehaviorSubject<AccountFindType>(value: self.accountFindType) )
        
        
        let output = viewModel.transform(input: input)
        
        // 이메일 주소 또는 닉네임 정규식 검증 결과
        output.isValidNicknameOrEmail
            .bind(onNext: { [weak self] valid in
                self?.accountFinderView.nicknameOrEmailFeedbackLabel.isHidden = valid
            })
            .disposed(by: disposeBag)
        
        // 휴대폰 번호 정규식 검증 결과
        output.isValidTell
            .bind(onNext: { [weak self] valid in
                self?.accountFinderView.tellFeedbackLabel.isHidden = valid
            })
            .disposed(by: disposeBag)
        
        // 계정 찾기 버튼 활성화 결과
        output.isFindButtonEnabled
            .bind(onNext: { [weak self] valid in
                guard let self = self else { return }
                accountFinderView.findButton.isEnabled = valid
                valid ? (accountFinderView.findButton.backgroundColor = .buttonAbleColor) : (accountFinderView.findButton.backgroundColor = .buttonDisableColor)
            })
            .disposed(by: disposeBag)
        
        // 계정 찾기 성공: 찾은 이메일 주소 또는 임시 비밀번호가 결과
        output.accountFindSuccess
            .bind(onNext: { [weak self] result in
                guard let self = self else { return }
                let accountFinderSuccessVC = AccountFinderSuccessViewController(findType: accountFindType, resultInfo: result)
                
                if let sheet = accountFinderSuccessVC.sheetPresentationController { // 바텀 시트로 띄우기
                    sheet.detents = [.medium()] // 시트의 사이즈 설정. 중간
                    sheet.prefersGrabberVisible = false // 상단의 그랩 바 제거
                    sheet.preferredCornerRadius = 30 // 모서리 둥글게
                    sheet.prefersScrollingExpandsWhenScrolledToEdge = false // 스크롤로 확장 제거
                    sheet.animateChanges {
                        sheet.selectedDetentIdentifier = .medium
                    }
                }
                accountFinderSuccessVC.isModalInPresentation = true // 스크롤과 터치할 때 dismiss를 방지
                present(accountFinderSuccessVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        // 계정 찾기 실패: 팝업 띄우기
        output.accountFindFailure
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                let popUpVC: PopUpViewController
                switch accountFindType {
                case .findEmail:
                    popUpVC = PopUpViewController(title: "이메일 주소 찾기에\n실패했어요", subTitle: "닉네임 또는 휴대폰 번호를 다시 확인해 주세요", closeType: .dismissSingleModal)
                case .findPassword:
                    popUpVC = PopUpViewController(title: "비밀번호 찾기에\n실패했어요", subTitle: "이메일 주소 또는 휴대폰 번호를 다시 확인해 주세요", closeType: .dismissSingleModal)
                }
                present(popUpVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        
    }
    
} // closed AccountFinderViewController

// extension
extension AccountFinderViewController {
    // 키보드가 올라왔을 때 툴바를 적용하고, 완료버튼을 누르면 키보드 내리기
    private func setupTextFields() {
        [accountFinderView.nicknameOrEmailTextField, accountFinderView.tellTextField]
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
    
    // 완료버튼을 누르면 키보드 내리기
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}
