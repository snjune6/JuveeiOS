//
//  CurrentOrderListView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/13.
//

import SwiftUI

struct CurrentOrderListView: View {
    
    @EnvironmentObject var apiVM: ApiVM
    
    @Binding var ordersList: [OrdersDto]
    
    var body: some View {
        HStack {
            Image("current_order")
                .padding([.leading])
                .padding(.bottom, 4)
                .padding(.top, 10)
            
            Text("\(ordersList.count)")
                .padding(.bottom, 4)
                .padding(.top, 10)
                .foregroundColor(Color(hex: 0xff007a))
                .font(.system(size: 13))
            Spacer()
        }
        
        
        // 오더리스트가 한개도 없을때
        if ordersList.count == 0 {
            ZStack {
                Image("rectangle_514")
                    .onTapGesture {
                        
                    }
                /*VStack {
                    Image("empty_order_list")
                        .padding()
                    Spacer()
                }*/
            }
            .padding(.bottom)
        } else {
            ForEach(ordersList, id: \.id) { orders in
                ZStack {
                    VStack {
                        HStack {
                            Text("\(orders.createdAt)")
                                .foregroundColor(Color(hex: 0xb5b5b6))
                                .font(.system(size: 13))
                                .padding(.horizontal)
                            Spacer()
                            Text("#\(orders.orderId)")
                                .font(.system(size: 15))
                                .padding(.horizontal)
                        }
                        Divider()
                        HStack(spacing: 25) {
                            if orders.status == "Ordered" {
                                Image("group")
                                Image("in_review_str")
                            } else if orders.status == "Ready" {
                                Image("making")
                                Image("making_str")
                            } else if orders.status == "In Transit" {
                                Image("transit")
                                Image("transit_str")
                            } else {
                                Image("delivered")
                                Image("delivered_str")
                            }
                        }
                        .padding(.vertical, 32)
                        .padding(.top, 15)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("In Review")
                                    .font(.system(size: 13))
                                if orders.status == "Ordered" {
                                    Image("rectangle_516")
                                } else {
                                    Image("rectangle_522")
                                }
                            }
                            VStack(alignment: .leading) {
                                Text("In Making")
                                    .font(.system(size: 13))
                                if orders.status == "Ordered" {
                                    Image("rectangle_521")
                                } else if orders.status == "Ready" {
                                    Image("rectangle_516")
                                } else {
                                    Image("rectangle_522")
                                }
                            }
                            VStack(alignment: .leading) {
                                Text("In Transit")
                                    .font(.system(size: 13))
                                if orders.status == "Ordered" {
                                    Image("rectangle_521")
                                } else if orders.status == "Ready" {
                                    Image("rectangle_521")
                                } else if orders.status == "In Transit" {
                                    Image("rectangle_516")
                                } else {
                                    Image("rectangle_522")
                                }
                            }
                            VStack(alignment: .leading) {
                                Text("Delivered")
                                    .font(.system(size: 13))
                                if orders.status == "Ordered" {
                                    Image("rectangle_521")
                                } else if orders.status == "Ready" {
                                    Image("rectangle_521")
                                } else if orders.status == "In Transit" {
                                    Image("rectangle_521")
                                } else {
                                    Image("rectangle_516")
                                }
                            }
                        }
                        .padding(5)
                        Image("vector_1_stroke")
                            .frame(maxWidth: UIScreen.main.bounds.width - 32)
                        VStack {
                            HStack {
                                Image("estimated_delivery")
                                    .padding(.horizontal)
                                Spacer()
                                Text("\(orders.estimated_at)")
                                    .font(.system(size: 12))
                                    .padding(.horizontal)
                            }
                            if orders.fulfillment != "-" {
                                HStack {
                                    Text("Tracking #")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                        .padding(4)
                                    Spacer()
                                    Text("#\(orders.orderId)")
                                        .font(.system(size: 13))
                                        .foregroundColor(Color(hex: 0xff007a))
                                        .padding(4)
                                }
                                .frame(width: UIScreen.main.bounds.width - 64)
                                .background(Color.black)
                                .cornerRadius(3)
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 32, height: 350)
                    .background(
                        ZStack {
                            Image("rectangle_531")
                                .offset(y: -126)
                                .zIndex(1)
                            Image("rectangle_532")
                                .offset(x: 157, y: -100)
                                .zIndex(1)
                            Image("rectangle_533")
                                .offset(x: -165)
                                .zIndex(1)
                            Image("rectangle_534")
                                .offset(x: 157 )
                                .zIndex(1)
                            Color.white
                        }
                    )
                }
            }
        }
    }
}
