//
//  BaseInterceptor.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation

import Alamofire

class BaseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        request.addValue("newApiKey", forHTTPHeaderField: UserDefaultManager.shared.getApiKey())
        completion(.success(request))
    }
}
