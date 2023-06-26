//
//  CommonLayout.swift
//  juvee
//
//  Created by 이미연 on 2023/06/13.
//

import SwiftUI

struct CommonLayout: View {
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var loginData: LoginData
    @EnvironmentObject var apiVM: ApiVM
    
    @State var siderbarOrdersCnt: Int = 0

    var body: some View {
        ZStack {
            ZStack {
                HStack {
                    if siderbarData.menuCode == "dashboardView" {
                        Button {
                            siderbarData.isSiderVisible.toggle()
                        } label: {
                            ZStack {
                                if siderbarOrdersCnt > 0 {
                                    ZStack {
                                        Image("icon_Menu_cnt")
                                        Text("\(siderbarOrdersCnt)")
                                            .foregroundColor(.white)
                                            .offset(x: 7, y: -4)
                                            .font(.system(size: 12))
                                    }
                                } else {
                                    Image("icon_Menu")
                                }
                            }
                        }
                        .padding(.leading)
                        .frame(width: 20.0, height: 20.0)
                    } else {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                siderbarData.isSiderVisible = false
                                siderbarData.menuCode = siderbarData.backPage
                                siderbarData.menuClick = false
                                siderbarData.layoutGB = 1
                            }
                        }, label: {
                            Image("arrow_color")
                        })
                        
                        Image("\(siderbarData.loginTitle)")
                            .padding(.horizontal)
                    }
                    Spacer()
                    Image("logo")
                }
                .offset(y: -UIScreen.main.bounds.height/2.4)
                .padding([.horizontal, .top])
            }
            .edgesIgnoringSafeArea(.all)
            
            if siderbarData.menuCode == "dashboardView" {
                DashboardView()
            } else if siderbarData.menuCode == "orderListView" {
                OrderListView()
                    .onAppear(perform: {
                        siderbarData.backPage = "dashboardView"
                    })
            } else if siderbarData.menuCode == "tutorialView" {
                TutorialView()
            }
            
            SidebarView()
        }
        .onAppear(perform: {
            print("loginData.accesstoken : \(loginData.accesstoken)")
            print("loginData.loginYN : \(loginData.loginYn)")
        })
        .onReceive(self.apiVM.getOrdersCntSuccess, perform: {
            siderbarOrdersCnt = self.apiVM.getOrdersCnt
        })
    }
}

struct CommonLayout_Previews: PreviewProvider {
    static var previews: some View {
        CommonLayout()
    }
}
