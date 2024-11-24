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
        return UIColor(red: 242.0 / 255.0, green: 244.0 / 255.0, blue: 248.0 / 255.0, alpha: 1)
    }
    
    // MARK: - 앱 메인 색상
    static var mainColor: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 100.0 / 255.0, blue: 255.0 / 255.0, alpha: 1) // 토스
    }
    
    // MARK: - 비활성화 색상
    static var disableColor: UIColor {
        return .systemGray4
    }
    
    // MARK: - 검정 텍스트 색상
    static var mainTextColor: UIColor {
        return UIColor(red: 17.0 / 255.0, green: 17.0 / 255.0, blue: 17.0 / 255.0, alpha: 1)
    }
    
    // MARK: - 메인 네이비 텍스트 색상
    static var mainNavyColor: UIColor {
        return UIColor(red: 26.0 / 255.0, green: 31.0 / 255.0, blue: 54.0 / 255.0, alpha: 1)
    }
    
    // MARK: - 서브 텍스트 색상
    static var subTextColor: UIColor {
        return UIColor.systemGray
    }
    
    // MARK: - 진행상태 바 배경색상
    static var progressViewBackgroundColor: UIColor {
        return UIColor(red: 244.0 / 255.0, green: 244.0 / 255.0, blue: 244.0 / 255.0, alpha: 1)
    }
    
    // MARK: - 셀 선택 시 배경색상
    static var cellSelectedBackgroundColor: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 207.0 / 255.0, blue: 150.0 / 255.0, alpha: 1)
    }
    
    // MARK: - > 버튼의 색상
    static var buttonColor: UIColor {
        return UIColor(red: 200.0 / 255.0, green: 205.0 / 255.0, blue: 220.0 / 255.0, alpha: 1)
    }
    
    // MARK: - 텍스트 입력란의 배경색상
    static var textFieldBackgroundColor: UIColor {
        return UIColor(red: 230.0 / 255.0, green: 232.0 / 255.0, blue: 240.0 / 255.0, alpha: 1)
    }
}
