//
//  SidebarView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI

struct SidebarView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.9
    var bgColor: Color =
          Color(hex: 0xFFFFFF)

    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(siderbarData.isSiderVisible ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: siderbarData.isSiderVisible)
            .onTapGesture {
                siderbarData.isSiderVisible.toggle()
            }
            content
        }
        .edgesIgnoringSafeArea(.all)
    }


    var content: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                bgColor
                VStack {
                    SiderHeaderView()
                    SiderMenuView()
                    Spacer()
                    SiderBottomView()
                }
            }
            .frame(width: sideBarWidth)
            .offset(x: siderbarData.isSiderVisible ? 0 : -sideBarWidth)
            .animation(.default, value: siderbarData.isSiderVisible)

            Spacer()
        }
    }
    
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
