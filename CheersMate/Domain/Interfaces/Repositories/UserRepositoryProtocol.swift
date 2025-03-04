//
//  UserRepositoryProtocol.swift
//  CheersMate
//
//  Created by 재훈 on 11/2/24.
//

// MARK: - Domain과 Data 영역의 의존성 역전을 위한 프로토콜(인터페이스)

import Foundation
import RxSwift

public protocol UserRepositoryProtocol {
    // 애플 로그인
    func loginWithApple()
    
    // 카카오 로그인
    func loginWithKakao()
}
