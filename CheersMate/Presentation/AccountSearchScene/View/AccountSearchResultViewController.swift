//
//  EmailSearchSuccessViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit
import RxSwift
import RxCocoa

final public class AccountSearchResultViewController: UIViewController {
    
    private let accountSearchResultView = AccountSearchResultView()
    private let disposeBag = DisposeBag()
    
    public init(viewType: ViewType, outcome: Outcome) {
        accountSearchResultView.configure(viewType: viewType, outcome: outcome)
        super.init(nibName: nil, bundle: nil)
    } // closed init
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed init
    
    public override func loadView() {
        self.view = accountSearchResultView
    } // closed loadView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindView()
    } // closed viewDidLoad
    
    // MARK: - 뷰 바인드
    private func bindView() {
        // MARK: - 이메일 찾기에 성공하고, 로그인 하기 버튼을 눌렀을 때 초기 로그인 화면으로 이동
        accountSearchResultView.completeButton.rx.tap
            .bind { [weak self] _ in
                // 이전 화면을 presentingViewController를 통해 불러오고 UINavigationController로 다운 캐스팅
                guard let presentingViewController = self?.presentingViewController as? UINavigationController else { return }
                // 루트 뷰를 제외한 모든 컨트롤러를 네비게이션 스택에서 pop
                presentingViewController.popToRootViewController(animated: true)
                // 현재 화면 제거
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    } // closed bindView

} // closed EmailSearchSuccessViewController
