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

final public class RecommendHomeViewController: UIViewController {
    
    private let recommendHomeView: RecommendHomeView = RecommendHomeView()
    private let disposeBag: DisposeBag = DisposeBag()
    
    public override func loadView() {
        self.view = recommendHomeView
    } // closed loadView

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        bindView()
        
    } // closed viewDidLoad
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recommendHomeView.cheersAnimationView.play()
    } // closed viewWillAppear
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        recommendHomeView.cheersAnimationView.stop()
    } // closed viewDidDisappear
    
    private func setupNavi() {
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    } // closed setupNavi
    
    private func bindView() {
        
        recommendHomeView.startButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                let recommendListVC = RecommendListViewController()
                self.navigationController?.pushViewController(recommendListVC, animated: true) }
            .disposed(by: disposeBag)
        
        
        
    } // closed bindView
    
    
    
    
} // closed RecommendViewController
