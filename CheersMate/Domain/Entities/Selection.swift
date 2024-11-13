//
//  RecommendItem.swift
//  CheersMate
//
//  Created by 재훈 on 11/6/24.
//

import Foundation

// MARK: - AI 추천 기능 중 테이블 셀에 들어가는 정보
public struct Selection: Hashable, Codable {
    let type: PageType
    let title: String
    let desc: String
    
    public init(from object: SelectionObject) {
        self.type = PageType(rawValue: object.type)!
        self.title = object.title
        self.desc = object.desc
    } // closed init
    
} // closed Selection
