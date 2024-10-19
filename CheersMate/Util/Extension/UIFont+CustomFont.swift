//
//  UIFont+CustomFont.swift
//  CheersMate
//
//  Created by 재훈 on 10/20/24.
//

import UIKit

extension UIFont {
    enum Family: String {
        case Light, Medium, Bold
    }
    
    static func gmarketSans(size: CGFloat = 10, family: Family = .Medium) -> UIFont {
        return UIFont(name: "GmarketSans\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
