//
//  RecommendItem.swift
//  CheersMate
//
//  Created by 재훈 on 11/6/24.
//

import Foundation

// MARK: - 추천 리스트 엔티티
public struct RecommendItem: Hashable, Codable {
    let emoji: String
    let desc: String
    let isChecked: Bool
}
