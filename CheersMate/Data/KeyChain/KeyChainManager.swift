//
//  KeyChainManager.swift
//  CheersMate
//
//  Created by 재훈 on 11/24/24.
//

// MARK: - 토큰 관리를 위한 싱글톤 키체인 매니저

import Foundation
import SwiftKeychainWrapper

public final class KeyChainManager {
    // 싱글톤으로 관리
    static let shared = KeyChainManager()
    private let queue = DispatchQueue(label: "com.keychain.manager.queue") // 직렬 큐: 동기적으로 실행
    private init() { }
    
    // 키체인 저장(value: 저장할 값, key: 사용할 키)
    public func saveKeyChain(_ value: String, forKey key: String) -> Bool {
        return queue.sync {
            KeychainWrapper.standard.set(value, forKey: key)
        }
    }
    
    //  키체인 반환(key: 반환할 값의 키)
    public func getKeyChain(forKey key: String) -> String? {
        return queue.sync {
            KeychainWrapper.standard.string(forKey: key)
        }
    }
    
    // 키체인 제거(key: 삭제할 값의 키)
    public func removeKeyChain(forKey key: String) -> Bool {
        return queue.sync {
            KeychainWrapper.standard.removeObject(forKey: key)
        }
    }
    
} // closed KeyChainManager
