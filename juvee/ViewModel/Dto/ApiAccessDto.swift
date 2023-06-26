//
//  ApiAccessDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation

struct ApiAccessDto: Codable, Identifiable {
    var uuid: UUID = UUID()
    var id: Int
    var newApiKey: String
    var oldApiKey: String
    var errorCode: String
    private enum CodingKeys: String, CodingKey {
        case id
        case newApiKey
        case oldApiKey
        case errorCode
    }
}
