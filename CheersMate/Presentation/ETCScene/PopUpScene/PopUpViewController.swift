//
//  PopUpViewController.swift
//  CheersMate
//
//  Created by 재훈 on 12/2/24.
//

// MARK: - 사용자에게 특정 작업을 완료하거나 중요한 메시지를 전달하기 위한 팝업 화면

import UIKit
import RxSwift
import RxCocoa

public final class PopUpViewController: UIViewController {
    
    private let popUpView: PopUpView
    private let popUpCloseType: PopUpCloseType // 팝업 화면 닫기 타입. 타입에 따라서 버튼의 동작이 다름.
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = popUpView
    }
    
    // viewWillAppear
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Haptics.shared.generateHaptics(style: .medium)
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    // init
    public init(title: String, subTitle: String, closeType: PopUpCloseType) {
        self.popUpView = PopUpView(title: title, subTitle: subTitle)
        self.popUpCloseType = closeType
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 바인드 뷰
    private func bindView() {
        popUpView.completeButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                switch popUpCloseType {
                case .dismissSingleModal: // 단일 모달 닫기
                    dismiss(animated: true)
                case .dismissNestedModals: // 이중 모달 닫기
                    presentingViewController?.presentingViewController?.dismiss(animated: true)
                case .dismissToRoot: // 네비게이션 루트까지 모두 닫기
                    navigationController?.popToRootViewController(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    

} // closed PopUpViewController
