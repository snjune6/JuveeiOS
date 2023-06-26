//
//  DataStore.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation
import Combine
import AuthenticationServices
import GoogleSignIn

// 메뉴이동, 사이드바 관련
final class SiderbarData: ObservableObject {
    
    let didChange = PassthroughSubject<SiderbarData, Never>()
    
    @Published var isSiderVisible: Bool = false
    @Published var menuClick: Bool = false
    @Published var menuCode: String = "" {
        didSet {
            didChange.send(self)
        }
    }
    var backPage: String = ""
    var layoutGB: Int = 1
    var loginTitle: String = ""
}

final class AlertData: ObservableObject {
    
    var alertTitle: String = "Alert"
    @Published var alertMsg: String = ""
    @Published var alertNum: Int = 0
    @Published var showAlert: Bool = false
    
}

final class LoginData: ObservableObject {
    
    let didChange = PassthroughSubject<LoginData, Never>()
    let didChange2 = PassthroughSubject<LoginData, Never>()
    
    var accesstoken: String = ""
    @Published var socialType: String = "" {
        didSet {
            print("change social type: \(socialType)")
        }
    }
    var authorization: ASAuthorization? = nil
    var googleAuthorization: GIDAuthentication?
    var profile: GIDProfileData?
    @Published var loginYn: Bool = false {
        didSet {
            if loginYn {
                self.accesstoken = UserDefaultManager.shared.getApiKey()
                self.socialType = UserDefaultManager.shared.getLoginDataSocial()
            } else {
                self.accesstoken = ""
                self.socialType = ""
            }
            
            didChange.send(self)
        }
    }
}

final class AppStateData: ObservableObject {
    
    let didChange = PassthroughSubject<AppStateData, Never>()
    
    var setCurrentPage: Int = 1
    @Published var loading: Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
}
