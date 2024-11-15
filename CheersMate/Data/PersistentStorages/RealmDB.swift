//
//  SelectionRealm.swift
//  CheersMate
//
//  Created by 재훈 on 11/10/24.
//

import Foundation
import Realm
import RealmSwift

// MARK: - SelectionRealmProtocol
public protocol RealmProtocol {
    // MARK: - 추천 선택지(감정, 동반자, 도수) DB에서 가져오기
    func readSelectionObject(type: PageType) -> [Selection]
    // MARK: - AI 추천 결과 DB에 저장하기
    func saveRecommendResult(recommendData: RecommendData) -> Bool
    // MARK: - AI 추천 결과 DB에서 가져오기
    func readRecommendResult() -> RecommendResult

} // closed SelectionRealmProtocol

// MARK: - SelectionRealmProtocol을 채택
public final class RealmDB: RealmProtocol {
    // 테이블
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    } // closed init
    
    // MARK: - 추천 선택지(감정, 동반자, 도수) DB에서 가져오기
    public func readSelectionObject(type: PageType) -> [Selection] {
        // SelectionObject 테이블을 불러오기
        let selectionObject = realm.objects(SelectionObject.self)
        // 매개변수로 전달받은 타입의 선택지만 가져오기
        return Array(selectionObject.where { $0.type == type.rawValue }.map{ Selection(from: $0)})
    } // closed readEmotions
    
    // MARK: - AI 추천 결과 DB에 저장하기
    public func saveRecommendResult(recommendData: RecommendData) -> Bool {
        do {
            try realm.write {
                let recommendObject = RecommendObject()
                // 감정
                recommendObject.emotion = recommendData.request.emotion
                // 동반자
                recommendObject.companion = recommendData.request.companion
                // 추천 주류
                recommendObject.recommendLiquor = Liquor.convert(liquor: recommendData.recommendLiquor[0].liquor) // Liquor타입을 LiquorObject로 변환 필요
                // 추천 음식
                recommendObject.foods.append(objectsIn: recommendData.food.map { Food.convert(food: $0)})
                // 비슷한 주류
                recommendObject.similarLiquors.append(objectsIn: recommendData.similarLiquor.compactMap { Liquor.convert(liquor: $0.liquor) })
                // recommendObject에 데이터 저장
                realm.add(recommendObject)
            }
        } catch {
            print("catch Realm saveRecommendResult Error: AI 추천 결과 DB에 저장하기 실패")
            return false
        } // closed do-catch
        return true
    } // closed saveRecommendResult
    
    // MARK: - AI 추천 결과 DB에서 가져오기
    public func readRecommendResult() -> RecommendResult {
        // recommendObject 테이블을 불러오기
        let recommendObject = realm.objects(RecommendObject.self)
        // recommendObject 테이블에서 날짜를 기준으로 내림차순하여 최신 값을 가져오기
        let firstRecommendObject = recommendObject.sorted(byKeyPath: "date", ascending: false)[0]
        // RecommendObject를 RecommendResult으로 변환
        return RecommendResult(from: firstRecommendObject)
    } // closed readRecommendResult
    
} // closed SelectionRealm
