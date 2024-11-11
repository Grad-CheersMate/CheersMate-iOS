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
public protocol SelectionRealmProtocol {
    // 감정, 동반자, 주종, 도수 별 조회
    func readSelectionObject(type: PageType) -> [Selection]

} // closed SelectionRealmProtocol

// MARK: - SelectionRealmProtocol을 채택
public final class SelectionRealm: SelectionRealmProtocol {
    // 테이블
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    } // closed init
    
    // 해당하는 데이터 읽어오기
    public func readSelectionObject(type: PageType) -> [Selection] {
        // SelectionObject 테이블을 불러오기
        let selectionObject = realm.objects(SelectionObject.self)
        // 매개변수로 전달받은 타입의 데이터만 가져오기
        return Array(selectionObject.where { $0.type == type.rawValue }.map{ Selection(from: $0)})
    } // closed readEmotions
    
} // closed SelectionRealm
