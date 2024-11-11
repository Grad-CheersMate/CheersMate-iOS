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

// MARK: - 감정, 동반자, 도수, 결과 페이지
public enum PageType: String, Hashable, Codable {
    case emotion // 감정 선택 화면
    case companion // 동반자 선택 화면
    case liquorVolume // 도수 선택 화면
    case recommendResult // 추천 결과 화면
}

// MARK: - 성공 또는 실패 구분
public enum Outcome: String {
    case success = "성공"
    case failure = "실패"
}

public enum Section: Hashable {
    case recommend // AI 추천 섹션
}

public enum Item: Hashable {
    case recommendListItem
}
