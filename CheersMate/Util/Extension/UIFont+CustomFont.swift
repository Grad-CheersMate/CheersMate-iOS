//
//  UIFont+CustomFont.swift
//  CheersMate
//
//  Created by 재훈 on 10/20/24.
//

import UIKit

// MARK: - 텍스트의 폰트를 설정
extension UIFont {
    // 폰트의 굵기
    enum gmarketSansFamily: String {
        case Light, Medium, Bold
    }
    enum pretendardFamily: String {
        case Regular, Medium, SemiBold
    }
    
    // 지마켓 산스
    static func gmarketSans(size: CGFloat = 10, family: gmarketSansFamily = .Medium) -> UIFont {
        return UIFont(name: "GmarketSans\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    // 프리텐다드 폰트
    static func pretendard(size: CGFloat = 10, family: pretendardFamily = .Medium) -> UIFont {
        return UIFont(name: "Pretendard-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

