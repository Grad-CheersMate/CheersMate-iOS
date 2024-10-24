//
//  UILabel+Spacing.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit

// MARK: - 텍스트의 행간 설정
extension UILabel {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
