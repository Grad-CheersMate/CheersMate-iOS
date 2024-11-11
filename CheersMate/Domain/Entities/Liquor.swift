//
//  Liquor.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation

// MARK: - 주류 응답 엔티티
public struct LiquorResponse: Codable {
    
}

// MARK: - 주류 엔티티
public struct Liquor: Codable {
    let name: String
    let volume: Int
    let imageUrl: String
}
