//
//  ProfileRes.swift
//  juvee
//
//  Created by 이미연 on 2023/06/20.
//

import Foundation

struct ProfileRes: Decodable {
    let all: ProfileDto
    enum CodingKeys: String, CodingKey {
        case all = "userDetail"
    }
}
