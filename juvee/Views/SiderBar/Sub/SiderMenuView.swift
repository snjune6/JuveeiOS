//
//  SideMenuView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI

struct SiderMenuView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var loginData: LoginData
    @EnvironmentObject var apiVM: ApiVM
    
    @State var siderbarOrdersCnt: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                
                Button(action: {
                    if loginData.loginYn {
                        UserDefaultManager.shared.logout()
                        loginData.loginYn = UserDefaultManager.shared.getLoginYN()
                        loginData.accesstoken = UserDefaultManager.shared.getApiKey()
                    } else {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            siderbarData.menuCode = "loginView"
                            siderbarData.menuClick = true
                            siderbarData.layoutGB = 0
                        }
                    }
                }, label: {
                    
                    if loginData.loginYn {
                        Image("juvee")
                            .padding(.vertical)
                    } else {
                        Image("Login")
                            .padding(.vertical)
                    }
                    Spacer()
                    if loginData.loginYn {
                        Image("icon_login")
                    } else {
                        Image("icon_not_login")
                    }
                    
                })
                
            }
            
            if loginData.loginYn {
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            siderbarData.menuCode = "orderListView"
                            siderbarData.isSiderVisible = false
                            siderbarData.menuClick = true
                            siderbarData.layoutGB = 1
                            siderbarData.loginTitle = "order_list_title"
                        }
                    }, label: {
                        Text("Order In Progress")
                            .padding(.vertical, 4)
                            .font(.system(size: 25))
                            .foregroundColor(Color.black)
                        Spacer()
                        ZStack {
                            Text("\(siderbarOrdersCnt)")
                                .zIndex(1)
                                .font(.system(size: 12))
                                .foregroundColor(.white )
                            if siderbarOrdersCnt > 0 {
                                Image("ellipse_4")
                            } else {
                                Image("menu")
                            }
                        }
                        .onAppear(perform: {
                            self.apiVM.GetOrdersCnt()
                        })
                        .onReceive(self.apiVM.getOrdersCntSuccess, perform: {
                            siderbarOrdersCnt = self.apiVM.getOrdersCnt
                        })
                    })
                }
            } else {
                HStack {
                    Image("order_in_progress")
                        .padding(4)
                    Spacer()
                    ZStack {
                        Text("1")
                            .zIndex(1)
                            .font(.system(size: 15))
                            .foregroundColor(.white )
                        Image("ellipse_4")
                    }
                }
                .hidden()
            }
            Divider()
            HStack {
                Text("Order Now")
                    .padding(.vertical, 4)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color(hex: 0xB5B5B6))
                Spacer()
                Image("menu")
            }
            Divider()
            HStack {
                Text("Tutorial")
                    .padding(.vertical, 4)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color(hex: 0xB5B5B6))
                Spacer()
                Image("menu")
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    siderbarData.backPage = "dashboardView"
                    siderbarData.isSiderVisible = false
                    siderbarData.layoutGB = 1
                    siderbarData.loginTitle = "tutorial_title"
                    siderbarData.menuClick = true
                    siderbarData.menuCode = "tutorialView"
                }
            }
            Divider()
            if loginData.loginYn {
                HStack {
                    Text("Profile")
                        .padding(.vertical, 4)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color(hex: 0xB5B5B6))
                    Spacer()
                    Image("menu")
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        siderbarData.backPage = "dashboardView"
                        siderbarData.isSiderVisible = false
                        siderbarData.layoutGB = 0
                        siderbarData.loginTitle = ""
                        siderbarData.menuClick = true
                        siderbarData.menuCode = "profileView"
                    }
                }
                Divider()
            }
            
        }
        .padding(.horizontal, 20)
    }
}

struct SiderMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SiderMenuView()
    }
}
