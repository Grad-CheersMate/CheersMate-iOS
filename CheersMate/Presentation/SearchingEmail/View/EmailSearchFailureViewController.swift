//
//  EmailSearchFailureViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit
import RxSwift
import RxCocoa

final class EmailSearchFailureViewController: UIViewController {

    private let emailSearchFailureView = EmailSearchFailureView()
    private let disposeBag = DisposeBag()
    private let naviTitle: String
    
    init(naviTitle: String) {
        self.naviTitle = naviTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = emailSearchFailureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupNavi()
        bindView()
    }
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        self.navigationItem.title = naviTitle
    }
    
    // MARK: - 뷰 바인드
    private func bindView() {
    }
    
    

}
