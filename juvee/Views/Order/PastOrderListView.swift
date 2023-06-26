//
//  PastOrderView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/13.
//

import SwiftUI

struct PastOrderListView: View {
    
    @EnvironmentObject var apiVM: ApiVM
    
    @Binding var ordersList: [OrdersDto]
    
    var body: some View {
        HStack {
            Image("past_order")
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
        if ordersList.count == 0 {
            
        } else {
            ZStack {
                VStack {
                    HStack {
                        Text("#0000")
                            .font(.system(size: 15))
                            .padding(.horizontal)
                        Spacer()
                    }
                    Divider()
                    VStack {
                        HStack {
                            Image("ordered")
                                .padding(.horizontal)
                            Spacer()
                            Text("May 22, 2023")
                                .foregroundColor(Color(hex: 0xB5B5B6))
                                .font(.system(size: 12))
                                .padding(.horizontal)
                        }
                        HStack {
                            Image("delivery_completion")
                                .padding(.horizontal)
                            Spacer()
                            Text("May 22, 2023")
                                .font(.system(size: 12))
                                .padding(.horizontal)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 100)
                .background(
                    Color.white
                )
            }
        }
    }
}
