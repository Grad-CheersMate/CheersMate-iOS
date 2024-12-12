//
//  CustomTabBarController.swift
//  CheersMate
//
//  Created by 재훈 on 11/6/24.
//

import UIKit

public final class MainTabBarController: UITabBarController  {

    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.delegate = self
        setupTabBar()
        setupBarApperance()
    }

    // 탭 바 및 뷰 컨트롤러 설정
    private func setupTabBar() {
        
        let homeNVC = createHomeScene()
        let searchNVC = createSearchScene()
        let recommendHomeNVC = createRecommendScene()
        let myPageNVC = createMyPageScene()
        
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

    }
    
    // createHomeScene
    private func createHomeScene() -> UINavigationController {
        // MARK: - Data Layer
        let liquorNet = LiquorNetwork(manager: LiquorNetworkManager(requestInterceptor: AuthInterceptor()))
        let liquorRP = LiquorRepository(network: liquorNet)
        // MARK: - Domain Layer
        let categoryUC = CategoryUseCase(repository: liquorRP)
        let homeVM = HomeViewModel(useCase: categoryUC)
        // MARK: - Presentation Layer
        let homeVC = HomeViewController(viewModel: homeVM)
        let homeNVC = UINavigationController(rootViewController: homeVC)
        homeNVC.setupNaviBarAppearance()
        return homeNVC
    }
    
    // createSearchScene
    private func createSearchScene() -> UINavigationController {
        // MARK: - Data Layer
        let liquorNet = LiquorNetwork(manager: LiquorNetworkManager(requestInterceptor: AuthInterceptor()))
        let liquorRP = LiquorRepository(network: liquorNet)
        // MARK: - Domain Layer
        let searchUC = SearchUseCase(repository: liquorRP)
        let searchVM = SearchViewModel(useCase: searchUC)
        // MARK: - Presentation Layer
        let searchVC = SearchViewController(viewModel: searchVM)
        let searchNVC = UINavigationController(rootViewController: searchVC)
        searchNVC.setupNaviBarAppearance()
        return searchNVC
    }
    
    // createRecommendScene
    private func createRecommendScene() -> UINavigationController {
        // AI 추천 네비게이션 컨트롤러 생성
        let recommendHomeVC = RecommendHomeViewController()
        let recommendHomeNVC = UINavigationController(rootViewController: recommendHomeVC)
        recommendHomeNVC.setupNaviBarAppearance()
        return recommendHomeNVC
    }
    
    // createMyPageScene
    private func createMyPageScene() -> UINavigationController {
        // 내 정보 네비게이션 컨트롤러 생성
        let myPageVC = MyPageViewController()
        let myPageNVC = UINavigationController(rootViewController: myPageVC)
        myPageNVC.setupNaviBarAppearance()
        return myPageNVC
    }
    
    // setupBarApperance
    private func setupBarApperance() {
        modalPresentationStyle = .fullScreen
        tabBar.backgroundColor = .backgroundColor
        tabBar.tintColor = .mainTextColor
        tabBar.barTintColor = .backgroundColor
        tabBar.isTranslucent = false
        
        tabBar.layer.borderWidth = 0.1
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        
        tabBarAppearance.shadowColor = .buttonColor // 탭 바 구분선 색상
        tabBar.standardAppearance = tabBarAppearance // 일반 상태
        tabBar.scrollEdgeAppearance = tabBarAppearance // 스크롤 상태
        
        let attributes = [NSAttributedString.Key.font: UIFont.gmarketSans(size: 12, family: .Medium)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
    
    
    
} // closed MainTabBarController

// extension
extension MainTabBarController: UITabBarControllerDelegate {
    // 탭 선택 시 호출되는 델리게이트 메서드
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        Haptics.shared.generateHaptics(style: .light)
    }
    

}
