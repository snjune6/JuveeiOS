//
//  GoogleSignInAuthenticator.swift
//  juvee
//
//  Created by 이미연 on 2023/06/16.
//

import Foundation
import GoogleSignIn

/// An observable class for authenticating via Google.
final class GoogleSignInAuthenticator: ObservableObject {
    
    // TODO: Replace this with your own ID.
    private let clientID = "108273173042-1gf3p6d47fa4ampfgeu3u4io7rloahq7.apps.googleusercontent.com"
    

    private lazy var configuration: GIDConfiguration = {
        return GIDConfiguration(clientID: clientID)
    }()

    private var authViewModel: AuthenticationViewModel
    private var apiVM: ApiVM
    private var reason: String = ""

    /// Creates an instance of this authenticator.
    /// - parameter authViewModel: The view model this authenticator will set logged in status on.
    init(authViewModel: AuthenticationViewModel, apiVM: ApiVM, reason: String) {
        self.authViewModel = authViewModel
        self.apiVM = apiVM
        self.reason = reason
    }

    /// Signs in the user based upon the selected account.'
    /// - note: Successful calls to this will set the `authViewModel`'s `state` property.
    func signIn() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("There is no root view controller!!!")
            return
        }

        GIDSignIn.sharedInstance.signIn(with: configuration,
                                        presenting: rootViewController) { user, error in
            guard let user = user else {
                print("Error! \(String(describing: error))")
                return
            }
            
            user.authentication.do { authentication, error in
                guard let authentication = authentication else { return }
                
                self.apiVM.googleLogin(jwt: authentication.idToken!)
                //return authentication.idToken!
            }
            
            
          self.authViewModel.state = .signedIn(user)
        }
    }

    /// Signs out the current user.
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        authViewModel.state = .signedOut
        UserDefaultManager.shared.logout()
    }

      /// Disconnects the previously granted scope and signs the user out.
  func disconnect() {
      GIDSignIn.sharedInstance.disconnect { error in
          if let error = error {
              print("Encountered error disconnecting scope: \(error).")
          }
          self.apiVM.withdrawal(reason: self.reason)
          self.signOut()
      }
  }
}
