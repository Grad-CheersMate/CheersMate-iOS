//
//  CustomTabBarController.swift
//  CheersMate
//
//  Created by 재훈 on 11/6/24.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    // 탭 바 및 뷰 컨트롤러 설정
    private func setupTabBar() {
        // 홈 뷰 네비게이션 컨트롤러 생성
        let homeVC = HomeViewController()
        let homeNVC = UINavigationController(rootViewController: homeVC)
        homeNVC.setupBarAppearance()
        
        // 검색 네비게이션 컨트롤러 생성
        let searchVC = SearchViewController()
        let searchNVC = UINavigationController(rootViewController: searchVC)
        searchNVC.setupBarAppearance()
        
        // 챗 봇 네비게이션 컨트롤러 생성
        let recommendHomeVC = RecommendHomeViewController()
        let recommendHomeNVC = UINavigationController(rootViewController: recommendHomeVC)
        recommendHomeNVC.setupBarAppearance()
        
        // 마이 페이지 네비게이션 컨트롤러 생성
        let myPageVC = MyPageViewController()
        let myPageNVC = UINavigationController(rootViewController: myPageVC)
        myPageNVC.setupBarAppearance()
        
        self.setViewControllers([homeNVC, searchNVC, recommendHomeNVC, myPageNVC], animated: true)
        
        if let items = self.tabBar.items {
            items[0].image = .home
            items[0].title = "홈"
            items[1].image = .search
            items[1].title = "검색"
            items[2].image = .sparkles
            items[2].title = "AI 추천"
            items[3].image = .myPage
            items[3].title = "내정보"
        }
        
        self.setupBarApperance()
    }

}
