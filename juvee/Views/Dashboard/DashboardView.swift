//
//  DashboardView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData

    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                ZStack {
                    Color.black
                    Image("Dashboard")
                        .resizable()
                        .scaledToFill()
                        .offset(y: -40)
                }
            }
        }
        .offset(y: UIScreen.main.bounds.height * 0.07)
        
        Button(action: {
            // 버튼을 클릭할 때 수행할 동작
            // 여기에 원하는 코드를 작성하세요
        }) {
            Image("Order Now")
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

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

