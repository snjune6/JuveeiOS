//
//  OrdersDto.swift
//  juvee
//
//  Created by 이미연 on 2023/06/19.
//

import Foundation

struct OrdersDto : Decodable {
    var id : String
    
    var orderId: String
    var orderUpdatedAt: String
    var checkoutWebhookId: String
    var status: String
    var address1: String?
    var city: String?
    var company: String?
    var country: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var zip: String?
    var camera: String?
    var updatedAt: String
    var createdAt: String
    var fileId: String
    var fulfillment: String = ""
    var estimated_at: String = ""
    enum CodingKeys: String, CodingKey {
        case id = "no"
        case orderId = "orderno"
        case orderUpdatedAt = "order_updated_at"
        case checkoutWebhookId = "checkoutwebhookid"
        case status
        case address1
        case city
        case company
        case country
        case firstName = "firstname"
        case lastName = "lastname"
        case phone
        case zip
        case camera
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case fileId = "file_id"
        case fulfillment = "fulfillment"
        case estimated_at = "estimated_at"
      }
}
