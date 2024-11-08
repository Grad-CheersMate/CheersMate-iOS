//
//  Enum.swift
//  CheersMate
//
//  Created by 재훈 on 11/4/24.
//

import Foundation

// MARK: - 텍스트 타입에 따른 정규식 검사 분류
public enum TextType {
    case email
    case password
    case nickname
    case tell
}

// MARK: - 뷰 타입에 따라 이메일 찾기 뷰 또는 비밀번호 찾기 뷰로 구분
public enum ViewType: String {
    case searchEmail = "이메일 찾기" // 이메일 찾기 뷰 타입
    case searchPassword = "비밀번호 찾기" // 비밀번호 찾기 뷰 타입
}

// MARK: - 성공 또는 실패 구분
public enum Outcome: String {
    case success = "성공"
    case failure = "실패"
}

public enum Section: Hashable, CaseIterable {
    case recommend // 추천 섹션
}

public enum Item: Hashable {
    case recommendItem(RecommendItem)
}
