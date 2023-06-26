//
//  ContentView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var alertData: AlertData
    @EnvironmentObject var loginData: LoginData
    @EnvironmentObject var appStateData: AppStateData
    @EnvironmentObject var apiVM: ApiVM
    
    var body: some View {
        ZStack {
            if self.appStateData.loading {
                LoaderView()
                    .zIndex(self.appStateData.loading ? 100 : 0)
            }
            if self.alertData.showAlert {
                PopupView()
                    .zIndex(9999)
            }
            IntegratedVIew()
                /*.alert(isPresented: $alertData.showAlert, content: {
                    
                    switch $alertData.alertNum.wrappedValue {
                    case -1:
                        return Alert(title: Text("Server Error"), message: Text(alertData.alertMsg), dismissButton: .default(Text("Exit"), action: {
                            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
                            exit(0)
                        }))
                    case 1:
                        return Alert(title: Text(alertData.alertTitle), message: Text(alertData.alertMsg), dismissButton: .default(Text("OK")) {
                            if let signupResponse = apiVM.signupReturn {
                                if signupResponse.code == "1" {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        siderbarData.backPage = "dashboardView"
                                        siderbarData.isSiderVisible = false
                                        siderbarData.menuCode = "loginView"
                                        siderbarData.layoutGB = 0
                                    }
                                } else {
                                    UserDefaultManager.shared.setLoginData(userId: "", email: "", userAccessToken: "", userExpiresAt: "", password: "")
                                }
                            }
                        })
                    case 2:
                        return Alert(title: Text(alertData.alertTitle), message: Text(alertData.alertMsg), dismissButton: .default(Text("OK")) {
                            if let profileResponse = apiVM.profileUpdateRes {
                                if profileResponse.code == "1" {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        siderbarData.backPage = ""
                                        siderbarData.isSiderVisible = false
                                        siderbarData.menuCode = "dashboardView"
                                        siderbarData.layoutGB = 1
                                    }
                                }
                            }
                        })
                    case 5:
                        return Alert(
                            title: Text(alertData.alertTitle),
                            message: Text(alertData.alertMsg),
                            primaryButton: .default(Text("To Integrate")) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    siderbarData.backPage = "dashboardView"
                                    siderbarData.isSiderVisible = false
                                    siderbarData.menuCode = "displaceSocialView"
                                    siderbarData.layoutGB = 0
                                    appStateData.loading = false
                                }
                            },
                            secondaryButton: .cancel(Text("Cancel")) {}
                        )
                    default: break
                        false
                    }
                    
                })*/
                
                .onChange(of: alertData.showAlert) { newValue in
                    if newValue == false {
                        if alertData.alertNum != 0 {
                            alertData.alertNum = 0
                        }
                        
                        if !alertData.alertMsg.isEmpty {
                            alertData.alertMsg = ""
                        }
                    }
                }
                .onChange(of: siderbarData.menuClick) { newValue in
                    if newValue == true {
                        siderbarData.menuClick = false
                        siderbarData.isSiderVisible = false
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: ASAuthorizationAppleIDProvider.credentialRevokedNotification)) { _ in
                    // 자격 증명 취소 알림 수신
                    print("사용자 자격 증명이 취소되었습니다.")
                    UserDefaultManager.shared.logout()
                    loginData.loginYn = false
                    loginData.accesstoken = ""
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SiderbarData())
            .environmentObject(AlertData())
            .environmentObject(LoginData())
            .environmentObject(ApiVM())
    }
}
