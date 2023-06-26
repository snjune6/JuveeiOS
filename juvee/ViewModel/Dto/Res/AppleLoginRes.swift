//
//  AppleLoginRes.swift
//  juvee
//
//  Created by 이미연 on 2023/06/15.
//

import Foundation

struct AppleLoginRes : Codable {
    var user: AppleUserDto
    var userDetail: UserDetailDto
    var token: TokenDto
    enum CodingKeys: String, CodingKey {
        case user
        case userDetail
        case token
    }
}
