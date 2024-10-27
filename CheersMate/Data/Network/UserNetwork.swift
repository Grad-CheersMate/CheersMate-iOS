//
//  UserNetwork.swift
//  CheersMate
//
//  Created by 재훈 on 10/27/24.
//

import Foundation

protocol UserNetworkProtocol {

}

final class UserNetwork: UserNetworkProtocol {
    private let manager: UserNetworkProtocol
    
    init(manager: UserNetworkProtocol) {
        self.manager = manager
    }

    
}
