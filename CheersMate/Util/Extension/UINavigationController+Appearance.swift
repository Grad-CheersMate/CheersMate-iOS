//
//  UINavigationController+Appearance.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit

extension UINavigationController {
    func setupNaviBarAppearance(backgroundColor: UIColor? = nil) {
        self.view.backgroundColor = backgroundColor
        
        let appearance = UINavigationBarAppearance()
        // 네비게이션 바를 투명하게 설정.
        appearance.configureWithTransparentBackground()
        
        // 네비게이션 바에 적용되는 텍스트 설정.
        appearance.titleTextAttributes = [.font:  UIFont.gmarketSans(size: 17, family: .Medium),
                                          .foregroundColor: UIColor.mainTextColor]
        
        // 네비게이션 바의 배경색상
        appearance.backgroundColor = backgroundColor

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.tintColor = .black
        navigationBar.prefersLargeTitles = false
    }
}
