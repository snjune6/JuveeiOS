//
//  TokenDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation

struct TokenDto: Codable {
    let tokenType: String = ""
    let accessToken, expiresAt, userId: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresAt = "expires_at"
        case accessToken = "access_token"
        case userId = "user_id"
    }
}
