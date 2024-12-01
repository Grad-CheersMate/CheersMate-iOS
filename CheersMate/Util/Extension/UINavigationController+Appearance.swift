//
//  UINavigationController+Appearance.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit

extension UINavigationController {
    func setupNaviBarAppearance() {
        let appearance = UINavigationBarAppearance()
        // 네비게이션 바를 투명하게 설정.
        appearance.configureWithTransparentBackground()
        // 네비게이션 바에 적용되는 텍스트 설정. 폰트 크기와 색상.
        appearance.titleTextAttributes = [.font:  UIFont.gmarketSans(size: 17, family: .Medium),
                                          .foregroundColor: UIColor.mainNavyColor]

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.tintColor = .black
        // 라지 타이틀 사용하지 않음.
        navigationBar.prefersLargeTitles = false
    }
}
