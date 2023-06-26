//
//  juveeApp.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI
import GoogleSignIn
import AuthenticationServices

@main
struct juveeApp: App {
    
    @StateObject var siderbarData = SiderbarData()
    @StateObject var alertData = AlertData()
    @StateObject var loginData = LoginData()
    @StateObject var appStateData = AppStateData()
    @StateObject var apiVM = ApiVM()
    
    var body: some Scene {
        WindowGroup {
            IntroView()
                .environmentObject(siderbarData)
                .environmentObject(alertData)
                .environmentObject(loginData)
                .environmentObject(appStateData)
                .environmentObject(apiVM)
                .environmentObject(AuthenticationViewModel(apiVM: apiVM))
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onChange(of: loginData.loginYn) { loginStatus in
                    if !loginStatus {
                        alertData.alertTitle = "USER"
                        alertData.showAlert = true
                        alertData.alertMsg = "You have been logged out."
                        siderbarData.layoutGB = 1
                        
                        siderbarData.isSiderVisible = false
                        siderbarData.menuClick = false
                    }
                }
                .onAppear(perform: {
                    siderbarData.backPage = "loginView"
                    siderbarData.menuCode = "dashboardView"
                    
                    loginData.loginYn = UserDefaultManager.shared.getLoginYN()
                    
                    UIApplication.shared.addTapGestureRecognizer()
                })
                
        }
    }
}
