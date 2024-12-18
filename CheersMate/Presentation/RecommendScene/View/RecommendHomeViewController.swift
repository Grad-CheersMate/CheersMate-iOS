//
//  ChatBotViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/26/24.
//

// 오늘의 날씨

// 현재 나의 기분
// 같이 먹을 사람
// 원하는 도수

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

final public class RecommendHomeViewController: UIViewController {
    
    private let recommendHomeView: RecommendHomeView = RecommendHomeView()
    private let disposeBag: DisposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = recommendHomeView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        bindView()
    }
    
    // viewWillAppear
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recommendHomeView.cheersAnimationView.play()
    }
    
    // viewWillDisappear
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recommendHomeView.cheersAnimationView.stop()
    }
    
    // setupNavi
    private func setupNavi() {
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainTextColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // bindView
    private func bindView() {
        
        recommendHomeView.startButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                // MARK: - Data Layer
                let realmDB = RealmDB(realm: try! Realm())
                let network = RecommendNetwork(manager: RecommendNetworkManager())
                // MARK: - Domain Layer
                let recommendRP = RecommendRepository(network: network, realm: realmDB)
                let recommendUC = RecommendUseCase(repository: recommendRP)
                // MARK: - Presentation Layer
                let recommendSelectionVM = RecommendSelectionViewModel(useCase: recommendUC)
                let recommendSelectionVC = RecommendSelectionViewController(viewModel: recommendSelectionVM)
                recommendSelectionVC.hidesBottomBarWhenPushed = true // 네비게이션에 Push할 때 탭 바를 화면에서 제거
                self.navigationController?.pushViewController(recommendSelectionVC, animated: true)
                Haptics.shared.generateHaptics(style: .medium)
            }
            .disposed(by: disposeBag)
    }
    
} // closed RecommendViewController
