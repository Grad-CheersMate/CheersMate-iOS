//
//  Haptics.swift
//  CheersMate
//
//  Created by 재훈 on 11/11/24.
//

// MARK: - 사용자의 화면 터치를 감지하고 진동을 발생

import UIKit

public final class Haptics {
    
    // MARK: - 싱글톤
    static let shared = Haptics()
    private init() { }
    
    public func generateHaptics(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let hapticGenerator = UIImpactFeedbackGenerator(style: style)
        hapticGenerator.prepare()
        hapticGenerator.impactOccurred()
    } // closed generateHaptics

} // closed Haptics
