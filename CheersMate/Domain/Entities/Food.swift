//
//  Food.swift
//  CheersMate
//
//  Created by 재훈 on 11/12/24.
//

import Foundation


// MARK: - 음식 엔티티
public struct Food: Codable, Hashable {
    let name: String
    let imageUrl: String
    
    // MARK: - Liquor를 Realm에 저장할 LiquorObject로 변환
    static func convert(food: Food) -> FoodObject {
        return FoodObject(name: food.name, imageUrl: food.imageUrl)
    } // closed convert
    
} // closed Food

