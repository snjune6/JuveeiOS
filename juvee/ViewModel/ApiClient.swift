//
//  ApiClient.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation

import Alamofire

final class ApiClient {
    
    static let shared = ApiClient()
    
    //static let BASE_URL = "http://192.168.20.172:8080"
    //static let BASE_URL = "http://20.127.153.157:8081"
    // 김준태
    static let BASE_URL = "http://192.168.20.172:8080"
    
    let interceotirs = Interceptor(interceptors: [
        BaseInterceptor()
    ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        print("ApiClient - init() called")
        
        session = Session(interceptor: interceotirs, eventMonitors: monitors)
    }
    
}
