//
//  ProfileDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/20.
//

import Foundation

struct ProfileDto : Decodable {
    var firstName: String
    var lastName: String
    var phone: String
    var zip: String
    var address1: String
    var provinceCode: String
    var province: String
    var city: String
    var countryCode: String
    var country: String
    var birthDay: String
    var gender: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case phone
        case zip
        case address1
        case provinceCode
        case province
        case city
        case countryCode
        case country
        case birthDay
        case gender
    }
}
