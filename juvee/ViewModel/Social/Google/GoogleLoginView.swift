//
//  GoogleLoginView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/16.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct GoogleLoginView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var apiVM: ApiVM
    @EnvironmentObject var loginData: LoginData
    
    
    
    var body: some View {
        GoogleSignInButton(scheme: .light, style: .standard, state: .normal, action: {
            GoogleSignInButtonAction()
        })
        .accessibilityIdentifier("GoogleSignInButton")
        .accessibility(hint: Text("Sign in with Google button."))
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
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
                self.apiVM.loginData = self.loginData
                self.apiVM.googleLogin(jwt: authentication.idToken!)
            }
            
            
            self.authViewModel.state = .signedIn(user)
            
        }
    }
}

struct GoogleLoginView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleLoginView()
    }
}
