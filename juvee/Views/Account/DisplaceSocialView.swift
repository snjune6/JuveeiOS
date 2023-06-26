//
//  DisplaceSocialView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/16.
//

import SwiftUI
import AuthenticationServices

struct DisplaceSocialView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var loginData: LoginData
    @EnvironmentObject var alertData: AlertData
    @EnvironmentObject var apiVM: ApiVM
    
    @State var socialEmail: String = ""
    @State var defaultEmail: String = ""
    @State var password: String = ""
    @State var firstNameInput: String = ""
    @State var lastNameInput: String = ""
    
    @State var jwtToken: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                HStack {
                    Image("forgot_str")
                    Spacer()
                }
                
                ZStack(alignment: .leading) {
                    Text("Social Email")
                        .font(.caption)
                        .foregroundColor(.white)
                        .offset(y: -35)
                    TextField("", text: $socialEmail)
                        .frame(height: 40, alignment: .center)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .imageScale(.small)
                        .keyboardType(.emailAddress)
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .padding(.horizontal, 8)
                        .disabled(true)
                }
                .background(.white)
                .padding(.top, 24)
                
                ZStack(alignment: .leading) {
                    Text("Default Email")
                        .font(.caption)
                        .foregroundColor(.white)
                        .offset(y: -35)
                    TextField("", text: $defaultEmail)
                        .frame(height: 40, alignment: .center)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .imageScale(.small)
                        .keyboardType(.emailAddress)
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .padding(.horizontal, 8)
                        .disabled(true)
                }
                .background(.white)
                .padding(.top, 24)
                
                ZStack(alignment: .leading) {
                    Text("Password")
                        .font(.caption)
                        .foregroundColor(.white)
                        .offset(y: -35)
                    SecureField("", text: $password)
                        .frame(height: 40, alignment: .center)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .imageScale(.small)
                        .keyboardType(.emailAddress)
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .padding(.horizontal, 8)
                }
                .background(.white)
                .padding(.top, 24)
                
                ZStack(alignment: .leading) {
                    Text("First Name")
                        .font(.caption)
                        .foregroundColor(.white)
                        .offset(y: -35)
                    TextField("", text: $firstNameInput)
                        .frame(height: 40, alignment: .center)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .imageScale(.small)
                        .keyboardType(.emailAddress)
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .padding(.horizontal, 8)
                }
                .background(.white)
                .padding(.top, 24)
                
                ZStack(alignment: .leading) {
                    Text("Last Name")
                        .font(.caption)
                        .foregroundColor(.white)
                        .offset(y: -35)
                    TextField("", text: $lastNameInput)
                        .frame(height: 40, alignment: .center)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .imageScale(.small)
                        .keyboardType(.emailAddress)
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .padding(.horizontal, 8)
                }
                .background(.white)
                .padding(.top, 24)
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .padding(.horizontal, 32)
            
            Button(action: {
                print(loginData.socialType)
                if self.loginData.socialType == "google" {
                    if password.isEmpty {
                        self.alertData.alertMsg = "Enter your Password."
                        self.alertData.alertTitle = loginData.socialType
                        self.alertData.showAlert = true
                        return
                    }
                    
                    if jwtToken.isEmpty {
                        self.alertData.alertMsg = "An error has occurred. Log out of settings and try again."
                        self.alertData.alertTitle = loginData.socialType
                        self.alertData.showAlert = true
                        return
                    }
                } else if self.loginData.socialType == "apple" {
                    if password.isEmpty {
                        self.alertData.alertMsg = "Enter your Password."
                        self.alertData.alertTitle = loginData.socialType
                        self.alertData.showAlert = true
                        return
                    }
                    
                    if jwtToken.isEmpty {
                        self.alertData.alertMsg = "An error has occurred. Log out of settings and try again."
                        self.alertData.alertTitle = loginData.socialType
                        self.alertData.showAlert = true
                        return
                    }
                }
                
                self.apiVM.alertData = alertData
                self.apiVM.alternateEmail(jwtToken: jwtToken, alternateEmail: defaultEmail, password: password, firstName: firstNameInput, lastName: lastNameInput, socialType: self.loginData.socialType)
                
            }) {
                Image("login_btn")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 64)
            }
            .padding(.vertical)
            .background(.black)
            .cornerRadius(50)
            .padding(.vertical)
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            self.siderbarData.backPage = "loginView"
            self.siderbarData.loginTitle = "forgot_pw_title"
            
            if loginData.socialType == "apple" {
                guard let authResult = $loginData.authorization.wrappedValue else {
                    return
                }
                
                if let appleIDCredential = authResult.credential as? ASAuthorizationAppleIDCredential {
                    if let email = appleIDCredential.email {
                        self.socialEmail = email
                        self.defaultEmail = email
                    }
                    
                    guard let appleIDToken = appleIDCredential.identityToken else {
                        return
                    }
                    
                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                        return
                    }
                    
                    guard let givenName = appleIDCredential.fullName?.givenName else {
                        return
                    }
                    
                    guard let familyName = appleIDCredential.fullName?.familyName else {
                        return
                    }
                    
                    firstNameInput = givenName
                    lastNameInput = familyName
                    
                    jwtToken = idTokenString
                }
            } else if loginData.socialType == "google" {
                
                guard let familyName = self.loginData.profile!.familyName else { return }
                guard let givenName = self.loginData.profile!.givenName else { return }
                guard let jwtTokens = self.loginData.googleAuthorization?.idToken! else { return }
                
                self.socialEmail = loginData.profile!.email
                self.defaultEmail = loginData.profile!.email
                
                self.firstNameInput = givenName
                self.lastNameInput = familyName
                self.jwtToken = jwtTokens
            }
        })
        .onReceive(apiVM.appleSocialLoginSuccess, perform: {
            if let appleLoginResponse = apiVM.appleLoginReturn {
                if appleLoginResponse.error == "1" {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.siderbarData.menuCode = "dashboardView"
                        self.siderbarData.layoutGB = 1
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.alertData.alertMsg = "Password is incorrect."
                        self.alertData.alertNum = 0
                        self.alertData.alertTitle = "Displace Error"
                        self.alertData.showAlert = true
                    }
                }
            }
        })
    }
}

struct DisplaceSocialView_Previews: PreviewProvider {
    static var previews: some View {
        DisplaceSocialView()
    }
}
