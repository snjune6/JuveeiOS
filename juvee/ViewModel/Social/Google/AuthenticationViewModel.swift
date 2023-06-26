//
//  AuthenticationViewModel.swift
//  juvee
//
//  Created by 이미연 on 2023/06/16.
//

import GoogleSignIn

/// A class conforming to `ObservableObject` used to represent a user's authentication status.
final class AuthenticationViewModel: ObservableObject {
    
    /// The user's log in status.
    /// - note: This will publish updates when its value changes.
    @Published var state: State
    
    private var authenticator: GoogleSignInAuthenticator {
        return GoogleSignInAuthenticator(authViewModel: self, apiVM: apiVM, reason: "")
    }
    
    private var apiVM: ApiVM
    /// The user-authorized scopes.sss
    /// - note: If the user is logged out, then this will default to empty.
    var authorizedScopes: [String] {
        switch state {
        case .signedIn(let user):
            return user.grantedScopes ?? []
        case .signedOut:
            return []
        }
    }

    /// Creates an instance of this view model.
    init(apiVM: ApiVM) {
        if let user = GIDSignIn.sharedInstance.currentUser {
            self.state = .signedIn(user)
        } else {
            self.state = .signedOut
        }
        self.apiVM = apiVM
    }

    /// Signs the user in.
    func signIn() {
        authenticator.signIn()
    }

    /// Signs the user out.
    func signOut() {
        authenticator.signOut()
    }

    /// Disconnects the previously granted scope and logs the user out.
    func disconnect() {
        authenticator.disconnect()
    }
    
}

extension AuthenticationViewModel {
    /// An enumeration representing logged in status.
    enum State {
        /// The user is logged in and is the associated value of this case.
        case signedIn(GIDGoogleUser)
        /// The user is logged out.
        case signedOut
    }
}
