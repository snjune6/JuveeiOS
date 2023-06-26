//
//  OrdersDetailsRes.swift
//  juvee
//
//  Created by 이미연 on 2023/06/19.
//

import Foundation

struct OrdersDetailsRes: Decodable {
    let all: OrdersDetailsDto
    let history: [HistoryDto]
    enum CodingKeys: String, CodingKey {
        case all = "orders"
        case history
    }
}
