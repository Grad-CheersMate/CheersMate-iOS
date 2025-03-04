//
//  UserRepository.swift
//  CheersMate
//
//  Created by 재훈 on 10/27/24.
//

import Foundation
import RxSwift

// MARK: - DB 또는 Network를 통해 Domain과 Data 영역을 연결해주는 Repository
// MARK: - DB는 Realm을 사용

public class UserRepository: UserRepositoryProtocol {
    
    private let network: UserNetworkProtocol
    
    // init
    public init(network: UserNetworkProtocol) {
        self.network = network
    }
    
    public func loginWithApple() {
        //
    }
    
    public func loginWithKakao() {
        //
    }
    
} // closed UserRepository
