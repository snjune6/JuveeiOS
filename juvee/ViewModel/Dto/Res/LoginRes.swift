//
//  LoginRes.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation

struct LoginRes : Codable {
    var user: UserDto
    var userDetail: UserDetailDto
    var token: TokenDto
    enum CodingKeys: String, CodingKey {
        case user
        case userDetail
        case token
    }
}
