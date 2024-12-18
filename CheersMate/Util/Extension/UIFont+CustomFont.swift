//
//  UIFont+CustomFont.swift
//  CheersMate
//
//  Created by 재훈 on 10/20/24.
//

import UIKit

// MARK: - 텍스트의 폰트를 설정

extension UIFont {
    // 지마켓 산스 굵기
    enum GmarketSansFamily: String {
        case Light, Medium, Bold
    }
    
    // 프리텐다드 굵기
    enum PretendardFamily: String {
        case Regular, Medium, SemiBold
    }
    
    // 지마켓 산스
    static func gmarketSans(size: CGFloat = 10, family: GmarketSansFamily = .Medium) -> UIFont {
        return UIFont(name: "GmarketSans\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // 프리텐다드
    static func pretendard(size: CGFloat = 10, family: PretendardFamily = .Medium) -> UIFont {
        return UIFont(name: "Pretendard-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // 머니그라피
    static func Moneygraphy(size: CGFloat) -> UIFont {
        return UIFont(name: "Moneygraphy-Rounded", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

