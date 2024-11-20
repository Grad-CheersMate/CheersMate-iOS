//
//  Enum.swift
//  CheersMate
//
//  Created by 재훈 on 11/4/24.
//

import Foundation

// 텍스트 타입에 따른 정규식 검사 분류
public enum TextType {
    case email // 이메일
    case password // 비밀번호
    case nickname // 닉네임
    case tell // 전화번호
}

// 뷰 타입에 따라 이메일 찾기 뷰 또는 비밀번호 찾기 뷰로 구분
public enum ViewType: String {
    case searchEmail = "이메일 찾기" // 이메일 찾기 뷰 타입
    case searchPassword = "비밀번호 찾기" // 비밀번호 찾기 뷰 타입
}

// 감정, 동반자, 도수, 결과 페이지
public enum PageType: String, Hashable, Codable {
    case emotion // 감정 선택 화면
    case companion // 동반자 선택 화면
    case liquorVolume // 도수 선택 화면
}

// 카테고리에서 상품의 타입
public enum ProductType: String {
    case best = "베스트"
    case beer = "맥주"
    case wine = "와인"
    case wishke = "위스키"
    case soju = "소주"
    case riceWine = "막걸리"
    case sake = "전통주"
}

// 성공 또는 실패 구분
public enum Outcome: String {
    case success = "성공"
    case failure = "실패"
}

// 컬렉션 뷰에서 섹션 정의
public enum Section: Hashable {
    case category // 홈 화면에서 주류 카테고리 섹션
    case selection // 추천 선택지 화면 선택지 섹션
    case recommendMain // 추천 결과 화면에서 추천 주류 섹션
    case recommendFood(String) // 추천 결과 화면에서 잘 어울리는 음식 섹션
    case recommendSimilar(String) // 추천 결과 화면에서 비슷한 주류 섹션
}

// 컬렉션 뷰에서 아이템 정의
public enum Item: Hashable {
    case productItem(Liquor) // 메인 상품(주류) 아이템
    case foodItem(Food) // 잘 어울리는 음식 아이템
    case similarItem(Liquor) // 비슷한 주류 아이템
}
