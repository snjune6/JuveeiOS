//
//  PasswordChangeView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/22.
//

import SwiftUI

struct PasswordChangeView: View {
    
    @State var emailInput: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                VStack {
                    HStack {
                        Text("Update Profile")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .bold))
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
                            .disabled(true)
                    }
                    .background(.white)
                    .padding(.top, 24)
                    
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
                .padding([.horizontal], 34)
                
                
                
            }
        }
        .zIndex(10)
        .padding()
        
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView()
    }
}
