//
//  AppleLogin.swift
//  juvee
//
//  Created by 이미연 on 2023/06/15.
//

import SwiftUI
import AuthenticationServices

struct AppleLoginView: View {
    
    @EnvironmentObject var loginData: LoginData
    @EnvironmentObject var alertData: AlertData
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var appStateData: AppStateData
    @EnvironmentObject var apiVM: ApiVM
    
    @State private var userIdentifierTemp: String = ""
    @State private var authResult: ASAuthorization? = nil
    
    var body: some View {
        VStack {
            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    // Handle the authorization completion
                    switch result {
                    case .success(let authResult):
                        self.appStateData.loading = true
                        self.loginData.socialType = "apple"
                        self.loginData.authorization = authResult
                        // Handle the successful authorization
                        if let appleIDCredential = authResult.credential as? ASAuthorizationAppleIDCredential {
                            let email = appleIDCredential.email
                            
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                return
                            }
                            
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                return
                            }
                            
                            self.apiVM.siderbarData = siderbarData
                            self.apiVM.loginData = loginData
                            self.apiVM.hasOnlyAppleAccount(jwtToken: idTokenString)
                            
                            //checkEmailDomain(email: email)
                        }
                        
                    case .failure(let error):
                        print("인증 실패: \(error.localizedDescription)")
                    }
                }
            )
            .signInWithAppleButtonStyle(.white)
            .frame(width: UIScreen.main.bounds.width - 64, height: 40)
            
            
        }
        .onAppear {
            // Check credential state
            checkCredentialState()
        }
        .onReceive(apiVM.defaultAppleLoginCheckSuccess, perform: {
            print("receive")
            if apiVM.defaultAppleLoginCheckReturn?.check == "1" {
                
                // 아이디 통합
                self.alertData.showAlert = true
                self.alertData.alertNum = 5
                self.alertData.alertMsg = "There is already an existing regular user account. Would you like to integrate it with your SNS account? Integration will not be possible if you choose to cancel.[Apple]"
                
                
            } else {
                
                guard let authResult = $loginData.authorization.wrappedValue else {
                    return
                }
                
                handleAuthorizationSuccess(authResult: authResult)
                
            }
        })
        .onReceive(apiVM.onlyAppleAccountSuccess, perform: {
            print(apiVM.onlyAppleAccount)
            if self.apiVM.onlyAppleAccount == 1 {
                // 일반로그인 처리
                guard let authResult = $loginData.authorization.wrappedValue else {
                    return
                }
                
                handleAuthorizationSuccess(authResult: authResult)
            } else {
                
                guard let authResult = $loginData.authorization.wrappedValue else {
                    return
                }
                
                if let appleIDCredential = authResult.credential as? ASAuthorizationAppleIDCredential {
                    let email = appleIDCredential.email
                    
                    if let email = email {
                        print("email : \(email)")
                        
                        let domain = "privaterelay.appleid.com"
                        
                        if email.contains(domain) {
                            // 이메일 숨김
                            self.alertData.showAlert = true
                            self.alertData.alertNum = 999
                            self.alertData.alertMsg = "If you select Hide My Email, you cannot sign up for Apple login."
                            self.alertData.alertTitle = "APPLE"
                        } else {
                            // 이메일 제공
                            handleAuthorizationUserCheck(authResult: loginData.authorization!)
                        }
                    } else {
                        self.alertData.showAlert = true
                        self.alertData.alertNum = 999
                        self.alertData.alertMsg = "Already authenticated user, but no registered users. Try disabling your Apple ID in 'Settings'"
                        self.alertData.alertTitle = "APPLE"
                    }
                    
                }
                
            }
        })
        
        
    }
    
    func handleAuthorizationUserCheck(authResult: ASAuthorization) {
        if let appleIDCredential = authResult.credential as? ASAuthorizationAppleIDCredential {
            self.apiVM.defaultAppleLoginCheck(email: appleIDCredential.email ?? "")
        }
        

    }
    
    func handleAuthorizationSuccess(authResult: ASAuthorization) {
        print("성공")
        if let appleIDCredential = authResult.credential as? ASAuthorizationAppleIDCredential {
            // Handle Apple ID credential
            let userIdentifier = appleIDCredential.user
            
            // Perform necessary actions with the credential data
            // ...
            userIdentifierTemp = userIdentifier;
            
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                return
            }
            
                        
            if let _ = appleIDCredential.email, let _ = appleIDCredential.fullName {
                guard let firstName = appleIDCredential.fullName?.givenName else {
                    return
                }
                
                guard let lastName = appleIDCredential.fullName?.familyName else {
                    return
                }
                
                self.apiVM.appleLogin(jwt: idTokenString, firstName: firstName, lastName: lastName)
            } else {
                self.apiVM.appleLogin2(jwt: idTokenString)
            }
        }
    }
    
    func checkCredentialState() {
        let provider = ASAuthorizationAppleIDProvider()//000787.090a07c989b4464f933df0566cb842a5.0805 김준태 000609.8daa3fe7269a418caf7684fab451f31c.0304 조예주
        print("userIdentifierTemp : \(userIdentifierTemp)")
        provider.getCredentialState(forUserID: userIdentifierTemp) { credentialState, error in
            if let error = error {
                // Error checking credential state
                print("Error checking credential state: \(error.localizedDescription)")
                return
            }
            
            switch credentialState {
            case .authorized:
                // User credential is authorized
                print("User credential is authorized")
            case .revoked:
                // User credential is revoked
                print("User credential is revoked")
            case .notFound:
                // User credential not found
                print("User credential not found")
            default:
                break
            }
        }
    }
    
    func checkEmailDomain(email: String?) {
        // 첫 로그인인지 확인
        if let email = email {
            
            let domain = "privaterelay.appleid.com"
            
            if email.contains(domain) {
                // 이메일 숨김
                self.alertData.showAlert = true
                self.alertData.alertNum = 999
                self.alertData.alertMsg = "If you select Hide My Email, you cannot sign up for Apple login."
                self.alertData.alertTitle = "APPLE"
            } else {
                // 이메일 제공
                handleAuthorizationUserCheck(authResult: loginData.authorization!)
            }
            
        } else {
            //두번째 로그인 처리
            print("이메일이 존재하지 않습니다.")
            
            let auth = $loginData.authorization
            if let appleIDCredential = auth.wrappedValue?.credential as? ASAuthorizationAppleIDCredential {
                
                guard let appleIDToken = appleIDCredential.identityToken else {
                    return
                }
                
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    return
                }
                
                print("idTokenString : \(idTokenString)")
                self.apiVM.appleLogin2(jwt: idTokenString)
            }
            
        }
    }
}
