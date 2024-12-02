//
//  Enum.swift
//  CheersMate
//
//  Created by 재훈 on 11/4/24.
//

import Foundation

// 정규식 검증 타입
public enum RegExType {
    case email // 이메일을 검증
    case password // 비밀번호를 검증
    case tell // 휴대폰 번호를 검증
}

// 사용자의 계정을 찾을 때 뷰의 타입: 뷰의 재사용을 위함
public enum AccountFindType: String {
    case email // 이메일 찾기
    case password // 비밀번호 찾기
    
    // 타이틀
    var title: String {
        switch self {
        case .email:
            return "이메일 찾기"
        case .password:
            return "비밀번호 찾기"
        }
    }
    
    // 설명
    var description: String {
        switch self {
        case .email:
            return "가입 시 등록한 정보를 입력하면\n이메일 주소를 알려드릴게요."
        case .password:
            return "가입 시 등록한 정보를 입력하면 휴대폰 번호로\n임시 비밀번호를 전송해 드릴게요."
        }
    }
    
    // 레이블과 플레이스 홀더 
    var userInfo: (label: String, placeholder: String) {
        switch self {
        case .email:
            return (label: "이메일 주소", placeholder: "이메일 주소를 입력해주세요")
        case .password:
            return (label: "닉네임", placeholder: "닉네임을 입력해주세요")
        }
    }
}

// 팝업 화면을 닫을 때 처리 타입
public enum PopUpCloseType: String {
    case dismissSingleModal // aVC -> bVC (단일 모달 닫기). present
    case dismissNestedModals // aVC -> bVC -> cVC (이중 모달 닫기). present + present
    case dismissToRoot // aVC -> bVC -> cVC (네비게이션 초기로). push + present

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
    case best
    case selection // 추천 선택지 화면 선택지 섹션
    case recommendMain // 추천 결과 화면에서 추천 주류 섹션
    case recommendFood(String) // 추천 결과 화면에서 잘 어울리는 음식 섹션
    case recommendSimilar(String) // 추천 결과 화면에서 비슷한 주류 섹션
}

// 마이페이지 섹션
public enum MyPageSection: Hashable {
    case userInfo // 이미지 피커, 이름, 전화번호, 이메일
    case editProfile // 프로필 수정 섹션
    case customerSupport // 고객센터 섹션
}

// 마이 페이지 아이템
public enum MyPageItem: Hashable {
    case userInfoItem(User)
    case editProfileItem(Option)
}

public struct Option: Hashable {
    let imageText: String
    let descTest: String
}


// 컬렉션 뷰에서 아이템 정의
public enum Item: Hashable {
    case productItem(Liquor) // 메인 상품(주류) 아이템
    case foodItem(Food) // 잘 어울리는 음식 아이템
    case similarItem(Liquor) // 비슷한 주류 아이템
}
