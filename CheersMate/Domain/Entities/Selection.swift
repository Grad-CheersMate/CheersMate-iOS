//
//  RecommendItem.swift
//  CheersMate
//
//  Created by 재훈 on 11/6/24.
//

import Foundation

// MARK: - 감정, 동반자, 주종, 도수
public enum SelectionType: String, Hashable, Codable {
    case emotion // 감정 선택
    case companion // 동반자 선택
    case liquorType // 주종 선택
    case liquorLevel // 도수 선택
}

// MARK: - AI 추천 기능 중 테이블 셀에 들어가는 정보
public struct Selection: Hashable, Codable {
    let type: SelectionType
    let imageName: String
    let desc: String
    let isChecked: Bool
    
    public init(from object: SelectionObject) {
        self.type = SelectionType(rawValue: object.type)!
        self.imageName = object.imageName
        self.desc = object.desc
        self.isChecked = object.isChecked
    } // closed init
    
} // closed Selection
