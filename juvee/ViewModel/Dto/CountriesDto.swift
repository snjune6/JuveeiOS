//
//  CountriesDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/20.
//

import Foundation

struct CountriesDto : Decodable {
    let id: String
    let countryId: String
    let name: String
    let code: String
    let taxName: String
    let taxType: String
    let shippingZoneId: String
    let tax: String
    let taxPercentage: String
    enum CodingKeys: String, CodingKey {
        case id
        case countryId = "country_id"
        case name
        case code
        case taxName = "tax_name"
        case taxType = "tax_type"
        case shippingZoneId = "shipping_zone_id"
        case tax
        case taxPercentage = "tax_percentage"
    }
}
