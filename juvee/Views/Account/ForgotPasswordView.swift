//
//  ForgotPasswordView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/13.
//

import SwiftUI
import Buy

struct ForgotPasswordView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var alertData: AlertData
    
    @State var emailInput: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                HStack {
                    Image("forgot_str")
                    Spacer()
                }
                
                ZStack(alignment: .leading) {
                    Text("Email Address")
                        .font(.caption)
                        .foregroundColor(.white)
                        .offset(y: -35)
                    TextField("", text: $emailInput)
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
                
                if emailInput.isEmpty {
                    alertData.alertMsg = "Please Check Your Email!"
                    alertData.alertTitle = "Email"
                    alertData.showAlert = true
                    return
                }
                
                if !emailInput.isValidEmail {
                    alertData.alertMsg = "Email format is incorrect!"
                    alertData.alertTitle = "Email"
                    alertData.showAlert = true
                    return
                }
                
                let client = Graph.Client(
                    shopDomain: "e32jyc.myshopify.com",
                    apiKey:     "4b32c8df906e9e8f21520ca8df275259",
                    locale:     Locale.current
                )
                
                let mutation = Storefront.buildMutation { $0
                    .customerRecover(email: "\(emailInput)") { $0
                        .customerUserErrors { $0
                            .message()
                        }
                    }
                }
                let task = client.mutateGraphWith(mutation) { response, error in
                    if let mutation = response?.customerRecover {
                        alertData.alertTitle = "FORGOT PW"
                        mutation.customerUserErrors.forEach {
                            alertData.showAlert = true
                            alertData.alertMsg = $0.message
                        }
                        
                        if !alertData.showAlert {
                            alertData.showAlert = true
                            alertData.alertMsg = "Success!"
                            alertData.alertNum = 1
                        }

                    } else {
                        alertData.showAlert = true
                        alertData.alertMsg = "Resetting password limit exceeded. Please try again later."
                    }
                }
                
                task.resume()
                
            }) {
                Image("send_btn")
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
            siderbarData.backPage = "loginView"
        })
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(SiderbarData())
    }
}
