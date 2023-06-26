//
//  UserDefaultManager.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation


class UserDefaultManager {
    enum Key: String, CaseIterable {
        case apiKey
        case userId, email, userAccessToken, userExpiresAt, password, tag // 로그인 관련 키값
        case userName, lastOrderNo, lastOrderAt, loginYN
        case appleNumber
        case userDetail
    }
    
    static let shared: UserDefaultManager = {
        return UserDefaultManager()
    }()
    
    
    func setApiKey(apiKey: String) {
        UserDefaults.standard.set(apiKey, forKey: Key.apiKey.rawValue)
    }
    
    func getApiKey() -> String {
        return UserDefaults.standard.string(forKey: Key.apiKey.rawValue) ?? ""
    }
    
    func setLoginData(userId: String, email: String, userAccessToken: String, userExpiresAt: String, password: String) {
        UserDefaults.standard.set(userId, forKey: Key.userId.rawValue)
        UserDefaults.standard.set(email, forKey: Key.email.rawValue)
        UserDefaults.standard.set(userAccessToken, forKey: Key.userAccessToken.rawValue)
        UserDefaults.standard.set(userExpiresAt, forKey: Key.userExpiresAt.rawValue)
        UserDefaults.standard.set(password, forKey: Key.password.rawValue)
    }
    
    func getLoginData() -> Login2Dto {
        let userId          = UserDefaults.standard.string(forKey: Key.userId.rawValue)          ?? ""
        let email           = UserDefaults.standard.string(forKey: Key.email.rawValue)           ?? ""
        let userAccessToken = UserDefaults.standard.string(forKey: Key.userAccessToken.rawValue) ?? ""
        let userExpiresAt   = UserDefaults.standard.string(forKey: Key.userExpiresAt.rawValue)   ?? ""
        let password        = UserDefaults.standard.string(forKey: Key.password.rawValue)        ?? ""
        
        return Login2Dto(userId: userId, email: email, userAccessToken: userAccessToken, UserExpiresAt: userExpiresAt, password: password)
    }
    
    func setUserDetail(userDetailDto: UserDetailDto) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(userDetailDto)
            UserDefaults.standard.set(data, forKey: Key.userDetail.rawValue)
        } catch {
            print("Failed to encode and save UserDetailDto: \(error)")
        }
    }

    
    func getUserDetail() -> UserDetailDto? {
        if let data = UserDefaults.standard.data(forKey: Key.userDetail.rawValue) {
            do {
                let decoder = JSONDecoder()
                let userDetailDto = try decoder.decode(UserDetailDto.self, from: data)
                return userDetailDto
            } catch {
                print("Failed to decode UserDetailDto: \(error)")
            }
        }
        return nil
    }

    
    func setUserName(userName: String) {
        UserDefaults.standard.set(userName, forKey: Key.userName.rawValue)
    }
    
    func getUserName() -> String {
        let userName = UserDefaults.standard.string(forKey: Key.userName.rawValue) ?? ""
        return userName
    }
    
    func setLastOrderNo(lastOrderNo: String) {
        UserDefaults.standard.set(lastOrderNo, forKey: Key.lastOrderNo.rawValue)
    }
    
    func getLastOrderNo() -> String {
        let lastOrderNo = UserDefaults.standard.string(forKey: Key.lastOrderNo.rawValue) ?? ""
        return lastOrderNo
    }
    
    func setLastOrderAt(lastOrderAt: String) {
        UserDefaults.standard.set(lastOrderAt, forKey: Key.lastOrderAt.rawValue)
    }
    
    func getLastOrderAt() -> String {
        let lastOrder = UserDefaults.standard.string(forKey: Key.lastOrderAt.rawValue) ?? ""
        return lastOrder
    }
    
    func setLoginYN(loginYN: Bool) {
        UserDefaults.standard.set(loginYN, forKey: Key.loginYN.rawValue)
    }
    
    func getLoginYN() -> Bool {
        let loginYN = UserDefaults.standard.bool(forKey: Key.loginYN.rawValue)
        
        return loginYN
    }
    
    func logout() {
        setLoginData(userId: "", email: UserDefaultManager.shared.getLoginData().email, userAccessToken: "", userExpiresAt: "", password: "")
        setUserName(userName: "")
        setLastOrderNo(lastOrderNo: "")
        setLastOrderAt(lastOrderAt: "")
        setLoginYN(loginYN: false)
        setApiKey(apiKey: "")
        setLoginDataSocial(tag: "")
    }
    
    func setAppleNumber(appleNumber: String){
        UserDefaults.standard.set(appleNumber, forKey: Key.appleNumber.rawValue)
    }
    
    func getAppleNumber() -> String {
        return UserDefaults.standard.string(forKey: Key.appleNumber.rawValue) ?? ""
    }
    
    func setLoginDataSocial(tag: String) {
        UserDefaults.standard.set(tag, forKey: Key.tag.rawValue)
    }
    
    func getLoginDataSocial() -> String {
        return UserDefaults.standard.string(forKey: Key.tag.rawValue) ?? ""
    }
}
