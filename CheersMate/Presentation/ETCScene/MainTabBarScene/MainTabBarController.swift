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
        self.modalPresentationStyle = .fullScreen
        self.delegate = self
        setupTabBar()
        setupTabBarApperance()
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
        recommendHomeNVC.setupNaviBarAppearance(backgroundColor: .white)
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
    private func setupTabBarApperance() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .mainTextColor // 탭 바 아이템을 선택했을 때 색상
        tabBar.isTranslucent = false
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9098039216, blue: 0.9215686275, alpha: 1)
        tabBar.layer.cornerRadius = tabBar.frame.height * 0.41
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance =  UITabBarItemAppearance()
        
        // 탭 바 아이템 노말 상태
        tabBarItemAppearance.normal.iconColor = .normalIconColor
        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.gmarketSans(size: 10, family: .Medium),
            NSAttributedString.Key.foregroundColor: UIColor.normalIconColor
        ]
        
        // 탭 바 아이템 클릭 상태
        tabBarItemAppearance.selected.iconColor = .selectedIconColor
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.gmarketSans(size: 10, family: .Medium),
            NSAttributedString.Key.foregroundColor: UIColor.selectedIconColor
        ]
    
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.configureWithTransparentBackground()
        
        // tabBarAppearance.shadowColor =  // 탭 바 구분선 색상
        tabBar.standardAppearance = tabBarAppearance // 일반 상태
        tabBar.scrollEdgeAppearance = tabBarAppearance // 스크롤 상태
    }
    
    
    
} // closed MainTabBarController

// extension
extension MainTabBarController: UITabBarControllerDelegate {
    // 탭 선택 시 호출되는 델리게이트 메서드
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        Haptics.shared.generateHaptics(style: .soft)
    }
    

}
