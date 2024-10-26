//
//  HomeViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
    }
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        // 네비게이션 바의 왼쪽과 오른쪽 설정
        navigationItem.leftBarButtonItem = homeView.leftBarButtonItem
        navigationItem.rightBarButtonItem = homeView.rightBarButtonItem
    } // closed setupNavi
    
}
