//
//  UITabBarController+Custom.swift
//  CheersMate
//
//  Created by 재훈 on 10/26/24.
//

import UIKit

extension UITabBarController {
    func setupBarApperance() {
        modalPresentationStyle = .fullScreen
        tabBar.backgroundColor = .backgroundColor
        tabBar.tintColor = .mainTextColor
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        
        tabBar.layer.borderWidth = 0.2
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        
        tabBarAppearance.shadowColor = .backgroundColor // 탭 바 구분선 색상
        tabBar.standardAppearance = tabBarAppearance // 일반 상태
        tabBar.scrollEdgeAppearance = tabBarAppearance // 스크롤 상태
        // 커스텀 폰트
        let attributes = [NSAttributedString.Key.font: UIFont.gmarketSans(size: 10, family: .Medium)]
        // 탭 바 아이템을 커스텀하여 전역적으로 설정
        UITabBarItem.appearance().setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
}
