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
        self.delegate = self  // Delegate 설정
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

    // 탭바 아이템이 선택될 때 호출되는 메서드
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // 현재 선택된 뷰컨트롤러와 동일한 탭이 선택되었는지 확인
        if viewController == tabBarController.selectedViewController {
            
            // 선택된 뷰컨트롤러가 네비게이션 컨트롤러인지 확인
            if let navController = viewController as? UINavigationController {
                
                // 네비게이션 스택의 뷰컨트롤러 개수가 1보다 큰지 확인 (루트가 아닌 경우)
                if navController.viewControllers.count > 1 {
                    
                    // 사용자에게 알림 표시
                    let alert = UIAlertController(title: "처음 화면으로 이동", message: "현재 화면을 닫고 처음 화면으로 돌아가시겠습니까?", preferredStyle: .alert)
                    
                    let yesAction = UIAlertAction(title: "예", style: .default) { _ in
                        // 네비게이션 스택을 팝하여 루트로 이동
                        navController.popToRootViewController(animated: true)
                    }
                    
                    let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
                    
                    alert.addAction(yesAction)
                    alert.addAction(noAction)
                    
                    // 알림창을 표시
                    navController.visibleViewController?.present(alert, animated: true, completion: nil)
                    
                    // 기본 동작을 막기 위해 false 반환
                    return false
                }
            }
        }
        
        // 기본 동작 허용
        return true
    }
}
