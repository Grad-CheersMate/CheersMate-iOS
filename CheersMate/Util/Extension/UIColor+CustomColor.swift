//
//  UIColor+CustomColor.swift
//  CheersMate
//
//  Created by 재훈 on 10/20/24.
//

import UIKit

extension UIColor {
    // MARK: - 앱 메인 배경색상
    static var backgroundColor: UIColor {
        return UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 200.0 / 255.0, alpha: 1)
    }
    
    // MARK: - 앱 메인 색상
    static var mainColor: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 69.0 / 255.0, blue: 69.0 / 255.0, alpha: 1) // 연핑크
        // return UIColor(red: 97.0 / 255.0, green: 94.0 / 255.0, blue: 252.0 / 255.0, alpha: 1) // 보라
        // return UIColor(red: 249.0 / 255.0, green: 84.0 / 255.0, blue: 84.0 / 255.0, alpha: 1) // 연핑크
        // return UIColor(red: 24.0 / 255.0, green: 54.0 / 255.0, blue: 130.0 / 255.0, alpha: 1)
    }
    
    // MARK: - 텍스트 색상
    static var textColor: UIColor {
        return UIColor(red: 17.0 / 255.0, green: 17.0 / 255.0, blue: 17.0 / 255.0, alpha: 1)
    }
    
    // MARK: - 진행상태 바 배경색상
    static var progressViewBackgroundColor: UIColor {
        return UIColor(red: 244.0 / 255.0, green: 244.0 / 255.0, blue: 244.0 / 255.0, alpha: 1)
    }
    
    // MARK: - 셀 선택 시 배경색상
    static var cellSelectedBackgroundColor: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 207.0 / 255.0, blue: 150.0 / 255.0, alpha: 1)
    }
}
