//
//  OrderListView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/13.
//

import SwiftUI

struct OrderListView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var apiVM: ApiVM
    @EnvironmentObject var appStateData: AppStateData
    
    @State var ordersList: [OrdersDto] = []
    @State var ordersList2: [OrdersDto] = []
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    CurrentOrderListView(ordersList: $ordersList)
                    PastOrderListView(ordersList: $ordersList2)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.77)
            Spacer()
        }
        .background(Color(hex: 0xEEEEEE))
        .offset(y: UIScreen.main.bounds.height * 0.07)
        .onAppear(perform: {
            appStateData.setCurrentPage = 1
            apiVM.getOrderList(gbcd: 1, currentPage: 1)
            apiVM.getOrderList(gbcd: 2, currentPage: 1)
        })
        .onReceive(apiVM.ordersListSuccess, perform: {
            ordersList += (apiVM.ordersListReturn?.all)!
        })
        .onReceive(apiVM.ordersListSuccess2, perform: {
            ordersList2 += (apiVM.ordersListReturn2?.all)!
        })
        
        Button(action: {
            // 버튼을 클릭할 때 수행할 동작
            // 여기에 원하는 코드를 작성하세요
        }) {
            Image("add_order")
            Spacer()
            Image("U")
        }
        .padding()
        .background(Color(hex: 0xff007a))
        .cornerRadius(50)
        .padding()
        .offset(y: UIScreen.main.bounds.height * 0.43)
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
