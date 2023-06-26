//
//  LoginDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/13.
//

import Foundation

struct Login2Dto: Codable {
    let userId: String
    let email: String
    let userAccessToken: String
    let UserExpiresAt: String
    let password: String
    enum CodingKeys: String, CodingKey {
        case userId
        case email
        case userAccessToken
        case UserExpiresAt
        case password
    }
}
