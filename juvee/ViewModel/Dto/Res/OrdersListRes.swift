//
//  OrdersListRes.swift
//  juvee
//
//  Created by 이미연 on 2023/06/19.
//

import Foundation

struct OrdersListRes: Decodable {
    let all: [OrdersDto]
    let ordersCnt: Int
    enum CodingKeys: String, CodingKey {
        case all = "orders"
        case ordersCnt
    }
}
