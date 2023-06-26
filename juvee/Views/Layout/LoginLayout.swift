//
//  LoginLayout.swift
//  juvee
//
//  Created by 이미연 on 2023/06/13.
//

import SwiftUI

struct LoginLayout: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    
    var body: some View {
        ZStack {
            ZStack {
                Image("intro3_1")
                    .offset(x: 130, y: -290)
                
                Image("intro1_3")
                    .offset(x: -40, y: 389)
                Image("intro1_2")
                    .offset(x: -180, y: 310)
                Image("intro1_1")
                    .offset(x: -130, y: 290)
                
                Image("intro4_3")
                    .offset(x: -200, y: 330)
            }
            .zIndex(1)
            ZStack {
                Color(hex: 0xff007a)
                HStack {
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                siderbarData.menuCode = siderbarData.backPage
                                siderbarData.menuClick = true
                                
                                if siderbarData.menuCode == "dashboardView" {
                                    siderbarData.layoutGB = 1
                                } else {
                                    siderbarData.layoutGB = 0
                                }
                            }
                        }, label: {
                            Image("arrow")
                        })
                        .padding([.leading, .top, .bottom])
                        Image(siderbarData.loginTitle)
                        Spacer()
                    }
                    .frame(minWidth: UIScreen.main.bounds.width * 0.6, maxWidth: UIScreen.main.bounds.width * 0.6)
                    Spacer()
                    Image("logo_1")
                    .padding()
                }
                .offset(y: -UIScreen.main.bounds.height/2.4)
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
           
            
            if siderbarData.menuCode == "loginView" {
                LoginView()
                    .offset(y: UIScreen.main.bounds.width * 0.15)
            } else if siderbarData.menuCode == "signupView" {
                SignupView()
                    .offset(y: UIScreen.main.bounds.width * 0.15)
            } else if siderbarData.menuCode == "forgotPasswordView" {
                ForgotPasswordView()
                    .offset(y: UIScreen.main.bounds.width * 0.15)
            } else if siderbarData.menuCode == "displaceSocialView" {
                DisplaceSocialView()
                    .offset(y: UIScreen.main.bounds.width * 0.15)
            } else if siderbarData.menuCode == "profileView" {
                ProfileView()
                    .offset(y: UIScreen.main.bounds.width * 0.15)
            } else if siderbarData.menuCode == "passwordChangeView" {
                PasswordChangeView()
                    .offset(y: UIScreen.main.bounds.width * 0.15)
            } else {
                SignupView()
                    .offset(y: UIScreen.main.bounds.width * 0.15)
            }
            
        }
    }
}

struct LoginLayout_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginLayout()
            .environmentObject(SiderbarData())
    }
}
