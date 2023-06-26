//
//  HistoryDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/19.
//

import Foundation

struct HistoryDto : Decodable {
    var id: Int
    
    var date : String
    var checkoutsId: String
    var ordersId: String
    var newStatus: String
    var previousStatus: String
    private enum CodingKeys: String, CodingKey{
        case id = "no"
        case date
        case checkoutsId = "checkouts_id"
        case ordersId = "orders_id"
        case newStatus = "new_status"
        case previousStatus = "previous_status"
    }
}
