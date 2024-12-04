//
//  EmailSearchSuccessViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit
import RxSwift
import RxCocoa

public final class AccountFinderSuccessViewController: UIViewController {
    
    private let accountFinderSuccessView: AccountFinderSuccessView
    private let accountFindType: AccountFindType // 이메일 찾기 또는 비밀번호 찾기
    private let disposeBag = DisposeBag()
    
    // init
    public init(findType: AccountFindType, resultInfo: String) {
        self.accountFindType = findType
        self.accountFinderSuccessView = AccountFinderSuccessView(type: findType, resultInfo: resultInfo)
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // loadView
    public override func loadView() {
        self.view = accountFinderSuccessView
    }
    
    // viewWillAppear
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Haptics.shared.generateHaptics(style: .medium)
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindView()
    }
    
    // 바인드 뷰
    private func bindView() {
        // 확인 버튼을 클릭했을 때. 로그인 화면으로 돌아가기
        accountFinderSuccessView.completeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let presentingViewController = self?.presentingViewController as? UINavigationController // 현재 화면을 표시해준 화면. 즉 이전 화면
                self?.dismiss(animated: true) { // 현재 화면 제거
                    presentingViewController?.popViewController(animated: true) // 이전 화면도 제거하여 로그인 화면으로 돌아가기
                }
            })
            .disposed(by: disposeBag)
    }

} // closed AccountSearchResultViewController
