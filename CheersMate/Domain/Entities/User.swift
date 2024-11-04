//
//  User.swift
//  CheersMate
//
//  Created by 재훈 on 11/1/24.
//

import Foundation

public struct UserResponse: Codable {
    let result: Int
    let resultCode: Int
    let user: User?
    let email: String?
    let tell: String?
    let accessToken: String?
    let refreshToken: String?
} // closed UserResponse

// MARK: - 사용자 엔티티
public struct User: Codable {
    let email: String? // 이메일
    let password: String? // 비밀번호
    let nickname: String? // 닉네임
    let tell: String? // 전화번호
} // closed User
