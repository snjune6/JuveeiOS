//
//  AppleUserDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/15.
//

import Foundation

struct AppleUserDto : Codable, Identifiable {
    var uuid: UUID = UUID()
    var id : String = ""
    var socialId: String = ""
    var name: String = ""
    var email: String = ""
    var error: String = ""
    var errorMsg: String = ""
    var password: String = ""
    private enum CodingKeys: String, CodingKey{
        case id
        case socialId
        case name
        case email
        case error
        case errorMsg
        case password
    }
}
