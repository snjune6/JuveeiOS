//
//  LoginView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct LoginView: View {
    
    @EnvironmentObject var alertData: AlertData
    @EnvironmentObject var apiVM: ApiVM
    @EnvironmentObject var appStateData: AppStateData
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var loginData: LoginData
    @EnvironmentObject var siderbarData: SiderbarData
    
    @State var emailInput: String = UserDefaultManager.shared.getLoginData().email
    @State var passwordInput: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            VStack {
                HStack {
                    Image("login_title")
                    Spacer()
                }
                ZStack(alignment: .leading) {
                    TextField("E-mail", text: $emailInput)
                        .frame(height: 40, alignment: .center)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .imageScale(.small)
                        .keyboardType(.emailAddress)
                        .autocapitalization(UITextAutocapitalizationType.none)
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
                .padding(.horizontal)
                .background(.white)
                
                ZStack(alignment: .leading) {
                    SecureField("Password", text: $passwordInput)
                        .frame(height: 40, alignment: .center)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .imageScale(.small)
                        .keyboardType(.emailAddress)
                        .autocapitalization(UITextAutocapitalizationType.none)
                }
                .padding(.horizontal)
                .background(.white)
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .padding(32)
            
            Button(action: {
                if self.isValidInputs() {
                    apiVM.siderbarData = siderbarData
                    apiVM.loginData = loginData
                    
                    var loginDto = LoginDto()
                    
                    loginDto.email = emailInput
                    loginDto.password = passwordInput
                    
                    apiVM.Login(dto: loginDto)
                    self.appStateData.loading = true
                }
            }) {
                Image("login_btn")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 64)
                    
            }
            .padding(.vertical)
            .background(.black)
            .cornerRadius(50)
            
            VStack {
                GoogleLoginView()
                AppleLoginView()
            }
            .padding(.vertical)
            
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        siderbarData.backPage = "loginView"
                        siderbarData.isSiderVisible = false
                        siderbarData.menuClick = false
                        siderbarData.menuCode = "forgotPasswordView"
                        siderbarData.layoutGB = 0
                        siderbarData.loginTitle = "forgot_pw_title"
                    }
                }, label: {
                    Image("forgot_pw")
                })
                HStack(spacing: 0) {
                    Divider()
                        .frame(width: 1)
                        .background(Color.white)
                }
                .frame(height: 15)
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        siderbarData.backPage = "loginView"
                        siderbarData.isSiderVisible = false
                        siderbarData.menuClick = false
                        siderbarData.menuCode = "signupView"
                        siderbarData.layoutGB = 0
                        siderbarData.loginTitle = "sign_up_title"
                    }
                }, label: {
                    Image("sign_up")
                })
                Spacer()
            }
            .foregroundColor(.white)
            Spacer()
            Spacer()
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            siderbarData.backPage = "dashboardView"
            withAnimation(.easeInOut(duration: 0.5)) {
                siderbarData.loginTitle = "login_form"
            }
        })
        .onReceive(apiVM.loginSuccess, perform: {
            if let loginResponse = apiVM.loginReturn {
                if loginResponse.error == "1" {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.siderbarData.menuCode = "dashboardView"
                        self.siderbarData.layoutGB = 1
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.alertData.alertMsg = loginResponse.errorMsg
                        self.alertData.alertTitle = "Login failure"
                        self.alertData.showAlert = true
                    }
                }
            }
            self.appStateData.loading = false
        })
        .onReceive(apiVM.appleSocialLoginSuccess, perform: {
            print("social type : \(self.loginData.socialType)")
            if let appleLoginResponse = apiVM.appleLoginReturn {
                if appleLoginResponse.error == "1" {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.siderbarData.menuCode = "dashboardView"
                        self.siderbarData.layoutGB = 1
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.alertData.alertMsg = appleLoginResponse.errorMsg
                        self.alertData.alertNum = 0
                        self.alertData.alertTitle = loginData.socialType
                        self.alertData.showAlert = true
                    }
                }
            }
            self.appStateData.loading = false
        })
        .onReceive(apiVM.googleSocialLoginSuccess, perform: {
            if let googleLoginResponse = apiVM.googleLoginReturn {
                alertData.alertMsg = googleLoginResponse.errorMsg
                                    
                if googleLoginResponse.error == "1" {
                    self.loginData.loginYn = true
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.siderbarData.menuCode = "dashboardView"
                        self.siderbarData.layoutGB = 1
                    }
                } else if googleLoginResponse.error == "11" {
                    alertData.showAlert = true
                    alertData.alertNum = 5
                    alertData.alertMsg = "There is already an existing regular user account. Would you like to integrate it with your SNS account? Integration will not be possible if you choose to cancel.[Google]"
                    alertData.alertTitle = "GOOGLE"
                } else {
                    alertData.showAlert = true
                }
            }
            
        })
    }
    
    fileprivate func isValidInputs() -> Bool {
        
        if self.emailInput == "" {
            self.alertData.alertTitle = "LOGIN"
            self.alertData.alertMsg = "Email can't be blank."
            self.alertData.showAlert = true
            return false
        } else if !self.emailInput.isValidEmail {
            self.alertData.alertTitle = "LOGIN"
            self.alertData.alertMsg = "Email is not valid."
            self.alertData.showAlert = true
        } else if self.passwordInput == "" {
            self.alertData.alertTitle = "LOGIN"
            self.alertData.alertMsg = "Password can't be blank."
            self.alertData.showAlert = true
            return false
        } else if self.passwordInput.isValidPassword {
            self.alertData.alertTitle = "LOGIN"
            self.alertData.alertMsg = "Password is not valid."
            self.alertData.showAlert = true
            return false
        }
        
        return true
    }
    
    func GoogleSignInButtonAction() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("There is no root view controller!!!")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(with: GIDConfiguration(clientID: "108273173042-1gf3p6d47fa4ampfgeu3u4io7rloahq7.apps.googleusercontent.com"),
                                        presenting: rootViewController) { user, error in
            guard let user = user, error == nil else {
                print("Error! \(String(describing: error))")
                return
            }
            
            guard let email = user.profile?.email else { return }
            guard let profiles = user.profile else { return }
            self.loginData.profile = profiles
            
            user.authentication.do { authentication, error in
                guard let authentication = authentication else { return }
                loginData.googleAuthorization = authentication
                self.loginData.socialType = "google"
                self.apiVM.loginData = self.loginData
                self.apiVM.googleLogin(jwt: authentication.idToken!)
            }
            
            
            self.authViewModel.state = .signedIn(user)
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SiderbarData())
    }
}

