//
//  UITabBarController+Custom.swift
//  CheersMate
//
//  Created by 재훈 on 10/26/24.
//

import UIKit

extension UITabBarController {
    func setupBarApperance() {
        self.modalPresentationStyle = .fullScreen
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        // 커스텀 폰트
        let attributes = [NSAttributedString.Key.font: UIFont.gmarketSans(size: 10, family: .Medium)]
        // 탭 바 아이템을 커스텀하여 전역적으로 설정
        UITabBarItem.appearance().setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
}
