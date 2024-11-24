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
    let id: Int?
    let name: String?
    let volume: Double?
    let type: String?
    let imageUrl: String?
    
    // MARK: - Liquor를 Realm에 저장할 LiquorObject로 변환
    static func convert(liquor: Liquor) -> LiquorObject {
        return LiquorObject(id: liquor.id ?? 0 , name: liquor.name ?? "", volume: liquor.volume ?? 0.0, type: liquor.type ?? "", imageUrl: liquor.imageUrl ?? "")
    } // closed convert
}

public enum LiquorType: String, Hashable {
    case beer // 맥주
    case soju // 소주
    case wine // 와인
    case riceWine // 막걸리
    case whiske // 위스키
    case sake // 전통주
}

// Liquors 데이터 모델
public struct LiquorsResponse: Codable{
    let result: Bool
    let httpCode: Int
    let liquors: LiquorsContent
}
// Liquors의 content 부분만 포함한 데이터 모델
public struct LiquorsContent: Codable{
    let content: [Liquors]
    let totalPages: Int
}
// Liquor 데이터 모델
public struct Liquors: Codable {
    let id: Int
    let name: String
    let volume: Double
    let imageUrl: String
    let category: String
}

