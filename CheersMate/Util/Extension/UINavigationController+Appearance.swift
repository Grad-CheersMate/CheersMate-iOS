//
//  UINavigationController+Appearance.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit

extension UINavigationController {
    func setupBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        appearance.titleTextAttributes = [.font:  UIFont.gmarketSans(size: 17, family: .Medium),
                                          .foregroundColor: UIColor.black]

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.tintColor = .black
        navigationBar.prefersLargeTitles = false
    }
}
