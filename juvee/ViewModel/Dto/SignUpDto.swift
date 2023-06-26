//
//  SignUpDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/14.
//

import Foundation


struct SignUpDto : Codable {
    var email: String = ""
    var password: String = ""
    var firstName: String = ""
    var lastName: String = ""
    
    var gender: String = "0"
    var birthDay: String = ""
    var phoneNumber: String = ""
    
    var notifications: Bool = false
    var termAgree: Bool = false
    var privacyAgree: Bool = false
}
