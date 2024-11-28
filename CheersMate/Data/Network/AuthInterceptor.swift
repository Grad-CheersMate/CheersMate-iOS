//
//  RequestInterceptor.swift
//  CheersMate
//
//  Created by 재훈 on 11/24/24.
//

import Foundation
import Alamofire

public final class AuthInterceptor: RequestInterceptor {
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        guard let accessToken = KeyChainManager.shared.getKeyChain(forKey: "AccessToken") else { return }
        request.headers.add(.contentType("application/json"))
        request.headers.add(.authorization(bearerToken: accessToken))
        completion(.success(request))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard let refreshToken = KeyChainManager.shared.getKeyChain(forKey: "RefreshToken") else { return }
    
        let headers = HTTPHeaders([
            .authorization(bearerToken: refreshToken),
            .contentType("application/json")
        ])
        
        AF.request("http://ceprj.gachon.ac.kr:60021/auth/refresh",
                   method: .post,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UserResponse.self) { response in
            switch response.result {
            case .success(let res):
                if res.result, res.httpCode == 200 {
                    guard let accessToken = res.accessToken else { return }
                    _ = KeyChainManager.shared.saveKeyChain(accessToken, forKey: "AccessToken")
                    completion(.retry)
                }
            case .failure(let err):
                completion(.doNotRetryWithError(err))
            }
        }
    }
    
} // closed AuthInterceptor
