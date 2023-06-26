//
//  OrdersDetailsDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/19.
//

import Foundation

struct OrdersDetailsDto : Decodable {
    var id: String
    var orderId: String
    var status: String
    var estimatedAt: String
    var createdAt: String
    var updatedAt: String
    var fileId: String
    var fulfillment: String
    enum CodingKeys: String, CodingKey {
        case id
        case orderId = "orderid"
        case status
        case estimatedAt = "estimatedat"
        case createdAt = "createdat"
        case updatedAt = "updatedat"
        case fileId = "file_id"
        case fulfillment = "fulfillmentid"
    }
}
