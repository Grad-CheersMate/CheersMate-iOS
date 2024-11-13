//
//  Liquor.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation

// MARK: - 주류 응답 엔티티
public struct LiquorResponse: Codable {
    let liquor: Liquor
}

// MARK: - 주류 엔티티
public struct Liquor: Codable, Hashable {
    let imageUrl: String?
    let name: String?
    let volume: Double?
    let type: String?
}
