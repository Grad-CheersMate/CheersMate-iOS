//
//  Realm.swift
//  CheersMate
//
//  Created by 재훈 on 11/9/24.
//

import Foundation
import RealmSwift

// MARK: - 선택지 Object
public final class SelectionObject: Object {
    @Persisted(primaryKey: true) var title: String
    @Persisted var desc: String
    @Persisted var type: String
    
    convenience init(title: String, desc: String, type: PageType) {
        self.init()
        self.title = title
        self.desc = desc
        self.type = type.rawValue
    } // closed init
    
} // closed SelectionRealm

// MARK: - 전체 추천 데이터 Object
// MARK: - Realm에서는 배열을 List<>타입으로 설정
public final class RecommendObject: Object {
    @Persisted var emotion: String // 감정
    @Persisted var companion: String // 동반자
    @Persisted var recommendLiquor: LiquorObject? // 주류 추천 배열
    @Persisted var foods: List<FoodObject> // 음식 추천 배열
    @Persisted var similarLiquors: List<LiquorObject> // 비슷한 주류 배열
    @Persisted var date = Date() // 정렬할 때 필요
}

// MARK: - 주류 Object
public final class LiquorObject: Object {
    @Persisted var name: String? // 주류명
    @Persisted var volume: Double? // 도수
    @Persisted var type: String? // 주종
    @Persisted var imageUrl: String? // 이미지
    
    convenience init(name: String, volume: Double, type: String, imageUrl: String) {
        self.init()
        self.name = name
        self.volume = volume
        self.type = type
        self.imageUrl = imageUrl
    } // closed init
    
    // LiquorObject를 Liquor로 변환하는 메서드
    func toLiquor() -> Liquor {
        return Liquor(name: name, volume: volume, type: type, imageUrl: imageUrl)
    }
    
} // closed LiquorObject


// MARK: - 음식 Object
public final class FoodObject: Object {
    @Persisted var name: String // 음식명
    @Persisted var imageUrl: String // 이미지
    
    convenience init(name: String, imageUrl: String) {
        self.init()
        self.name = name
        self.imageUrl = imageUrl
    } // closed init
    
    // FoodObject를 Food로 변환하는 메서드
    func toFood() -> Food {
        return Food(name: name, imageUrl: imageUrl)
    }
    
} // closed FoodObject

// MARK: - 카테고리 Object
public final class categoryObject: Object {
    @Persisted var name: String // 카테고리 이름
    @Persisted var imageUrl: String // 이미지
    
    convenience init(name: String, imageUrl: String) {
        self.init()
        self.name = name
        self.imageUrl = imageUrl
    } // closed init
    
} // closed FoodObject
