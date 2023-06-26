//
//  UserDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation

struct UserDto : Codable, Identifiable {
    var uuid: UUID = UUID()
    var id : String
    var name: String
    var email: String
    var error: String
    var errorMsg: String
    var password: String
    private enum CodingKeys: String, CodingKey{
        case id
        case name
        case email
        case error
        case errorMsg
        case password
    }
}
