//
//  CountriesRes.swift
//  juvee
//
//  Created by 이미연 on 2023/06/20.
//

import Foundation

struct CountriesRes: Decodable {
    let code: String
    let name: String
    let provinceDto: [CountriesDto]
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case provinceDto
    }
}
