//
//  UserDetailDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation

struct UserDetailDto : Codable, Identifiable {
    var id: String = ""
    
    var userId: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var orderNo: String = ""
    var orderCreateAt: String = ""
    var country: String = ""
    var countryCode: String = ""
    var address1: String = ""
    var address2: String = ""
    var city: String = ""
    var province: String = ""
    var provinceCode: String = ""
    var zip: String = ""
    var gender: String = ""
    var birthDay: String = ""
    var phone: String = ""
    var notifications: Bool = false
}
