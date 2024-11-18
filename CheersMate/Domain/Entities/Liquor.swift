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
    let name: String?
    let volume: Double?
    let type: String?
    let imageUrl: String?
    
    // MARK: - Liquor를 Realm에 저장할 LiquorObject로 변환
    static func convert(liquor: Liquor) -> LiquorObject {
        return LiquorObject(name: liquor.name ?? "", volume: liquor.volume ?? 0.0, type: liquor.type ?? "", imageUrl: liquor.imageUrl ?? "")
    } // closed convert
}

// MARK: -
public enum LiquorType: String, Hashable {
    case beer
    case soju
    case wine
    case riceWine
    case whiske
    case sake
}
