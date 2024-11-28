//
//  CustomTabBarController.swift
//  CheersMate
//
//  Created by 재훈 on 11/6/24.
//

import UIKit

public final class MainTabBarController: UITabBarController  {

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.delegate = self
    }

    // 탭 바 및 뷰 컨트롤러 설정
    private func setupTabBar() {
        // MARK: - Data Layer
        let weatherNet = WeatherNetwork(manager: WeatherNetworkManager())
        let weatherRP = WeatherRepository(network: weatherNet)
        // MARK: - Domain Layer
        let weatherUC = WeatherUseCase(repository: weatherRP)
        let homeVM = HomeViewModel(useCase: weatherUC)
        // MARK: - Presentation Layer
        let homeVC = HomeViewController(viewModel: homeVM)
        let homeNVC = UINavigationController(rootViewController: homeVC)
        homeNVC.setupBarAppearance()
        
        // MARK: - Data Layer
        let liquorNet = LiquorNetwork(manager: LiquorNetworkManager())
        let liquorRP = LiquorRepository(network: liquorNet)
        // MARK: - Domain Layer
        let searchUC = SearchUseCase(repository: liquorRP)
        let searchVM = SearchViewModel(useCase: searchUC)
        let searchVC = SearchViewController(viewModel: searchVM)
        let searchNVC = UINavigationController(rootViewController: searchVC)
        searchNVC.setupBarAppearance()
        
        // AI 추천 네비게이션 컨트롤러 생성
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
            items[3].image = .human
            items[3].title = "내 정보"
        }
        self.setupBarApperance()
    }
} // closed MainTabBarController

extension MainTabBarController: UITabBarControllerDelegate {
    // 탭 선택 시 호출되는 델리게이트 메서드
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        Haptics.shared.generateHaptics(style: .light)
    }
}
