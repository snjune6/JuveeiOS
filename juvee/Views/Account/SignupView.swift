//
//  SignupView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/13.
//

import SwiftUI

struct SignupView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var alertData: AlertData
    @EnvironmentObject var appStateData: AppStateData
    @EnvironmentObject var apiVM: ApiVM
    
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    @State var corfirmPasswordInput: String = ""
    @State var firstNameInput: String = ""
    @State var lastNameInput: String = ""
    
    @State var genderInput: String = "0"
    @State var birthDayInput: String = ""
    @State var phoneNumberInput: String = ""
    
    @State var notifications: Bool = true
    @State var termInput: Bool = false
    @State var privacyInput: Bool = false
    
    @State var popupVisible: Bool = false
    @State var popupGB: Int = 0
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(popupVisible ? 1 : 0)
            AgreeDocumentView(popupVisible: $popupVisible, popupGB: $popupGB)
        }
        .edgesIgnoringSafeArea(.all)
        .zIndex(15)
        VStack(alignment: .center) {
            ScrollView {
                VStack {
                    HStack {
                        Image("welcome_juvee")
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
                    
                    ZStack(alignment: .leading) {
                        Text("Password")
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -35)
                        SecureField("", text: $passwordInput)
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
                        Text("Corfirm Password")
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -35)
                        SecureField("", text: $corfirmPasswordInput)
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
                .padding([.horizontal], 34)
                
                
                VStack {
                    HStack {
                        Image("optional")
                        Spacer()
                    }
                    .padding(.vertical, 24)
                    
                    ZStack(alignment: .leading) {
                        Text("Identiifying Gender")
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -35)
                            .padding(.bottom, 8)
                        
                        HStack(spacing: 1) {
                            ZStack {
                                if genderInput == "1" {
                                    Image("signup_male_on")
                                        .zIndex(1)
                                    Image("check_black")
                                } else {
                                    Image("signup_male")
                                        .zIndex(1)
                                    Image("check_white")
                                        .onTapGesture {
                                            genderInput = "1"
                                        }
                                }
                            }
                            ZStack {
                                if genderInput == "2" {
                                    Image("signup_female_on")
                                        .zIndex(1)
                                    Image("check_black")
                                } else {
                                    Image("signup_female")
                                        .zIndex(1)
                                    Image("check_white")
                                        .onTapGesture {
                                            genderInput = "2"
                                        }
                                }
                            }
                            ZStack {
                                if genderInput == "3" {
                                    Image("signup_other_on")
                                        .zIndex(1)
                                    Image("check_black")
                                } else {
                                    Image("signup_other")
                                        .zIndex(1)
                                    Image("check_white")
                                        .onTapGesture {
                                            genderInput = "3"
                                        }
                                }
                            }
                        }
                    }
                    
                    
                    ZStack(alignment: .leading) {
                        Text("Date of Birth")
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -35)
                        TextField("19930000", text: $birthDayInput)
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
                        Text("Phone Number")
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -35)
                        TextField("+12020000000", text: $phoneNumberInput)
                            .frame(height: 40, alignment: .center)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                            .keyboardType(.emailAddress)
                            .autocapitalization(UITextAutocapitalizationType.none)
                            .padding(.horizontal, 8)
                    }
                    .background(.white)
                    .padding(.top, 24)
                    
                    HStack {
                        Image(notifications ? "check_box_on" : "check_box_off")
                            .resizable() // 이미지 크기 조정을 위해 resizable() 메서드를 사용합니다.
                            .frame(width: 25, height: 25) // 원하는 크기로 이미지를 조정합니다.
                        Image("check_str")
                    }
                    .onTapGesture {
                        notifications.toggle()
                    }
                    
                    Image("please_check")
                        .padding(.vertical, 32)
                    
                    HStack {
                        Image("terms_str")
                        Spacer()
                        Image(termInput ? "check_box_on" : "check_box_off")
                            .resizable() // 이미지 크기 조정을 위해 resizable() 메서드를 사용합니다.
                            .frame(width: 25, height: 25) // 원하는 크기로 이미지를 조정합니다.
                    }
                    .onTapGesture {
                        termInput.toggle()
                        if termInput {
                            popupVisible = true
                        }
                        popupGB = 1
                    }
                    
                    HStack {
                        Image("privacy_str")
                        Spacer()
                        Image(privacyInput ? "check_box_on" : "check_box_off")
                            .resizable() // 이미지 크기 조정을 위해 resizable() 메서드를 사용합니다.
                            .frame(width: 25, height: 25) // 원하는 크기로 이미지를 조정합니다.
                    }
                    .onTapGesture { value in
                        privacyInput.toggle()
                        
                        if privacyInput {
                            popupVisible = true
                        }
                        popupGB = 2
                        
                    }
                    
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
                        
                        if passwordInput.isEmpty {
                            alertData.alertMsg = "Please Check Your Confirm Password!"
                            alertData.alertTitle = "Password"
                            alertData.showAlert = true
                            return
                        }
                        
                        
                        if corfirmPasswordInput.isEmpty {
                            alertData.alertMsg = "Please Check Your Confirm Password!"
                            alertData.alertTitle = "Confirm Password"
                            alertData.showAlert = true
                            return
                        }
                        
                        if passwordInput != corfirmPasswordInput {
                            alertData.alertMsg = "Password And Confirm Password are different!"
                            alertData.alertTitle = "Password"
                            alertData.showAlert = true
                            return
                        }
                        
                        if firstNameInput.isEmpty {
                            alertData.alertMsg = "Please Check Your Confirm FirstName!"
                            alertData.alertTitle = "FirstName"
                            alertData.showAlert = true
                            return
                        }
                        
                        if lastNameInput.isEmpty {
                            alertData.alertMsg = "Please Check Your Confirm LastName!"
                            alertData.alertTitle = "LastName"
                            alertData.showAlert = true
                            return
                        }
                        
                        
                        if !termInput {
                            alertData.alertMsg = "Please Check Term & Conditions!"
                            alertData.alertTitle = "Term & Conditions"
                            alertData.showAlert = true
                            return
                        }
                        
                        if !privacyInput {
                            alertData.alertMsg = "Please Check privacy Policy!"
                            alertData.alertTitle = "Privacy Policy"
                            alertData.showAlert = true
                            return
                        }
                        
                        var signUpDto = SignUpDto()
                        
                        signUpDto.email = emailInput
                        signUpDto.password = passwordInput
                        signUpDto.firstName = firstNameInput
                        signUpDto.lastName = lastNameInput
                        
                        signUpDto.gender = genderInput
                        signUpDto.birthDay = birthDayInput
                        signUpDto.phoneNumber = phoneNumberInput
                        
                        signUpDto.notifications = notifications
                        signUpDto.termAgree = termInput
                        signUpDto.privacyAgree = privacyInput
                        
                        
                        apiVM.signUp(dto: signUpDto)
                    }, label: {
                        Image("create_account_str")
                            .padding()
                            .frame(maxWidth: UIScreen.main.bounds.width - 64)
                    })
                    
                    .background(.black)
                    .cornerRadius(50)
                    .padding(.top, 32)
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
                .padding(34)
                
            }
        }
        .zIndex(10)
        .padding()
        .onReceive(apiVM.signupSuccess, perform: {
            if let signupResponse = apiVM.signupReturn {
                self.alertData.alertMsg = signupResponse.message
                self.alertData.alertTitle = "SignUp"
                self.alertData.showAlert = true
                self.alertData.alertNum = 1
                
                if signupResponse.code == "1" {
                    UserDefaultManager.shared.setLoginData(userId: "", email: emailInput, userAccessToken: "", userExpiresAt: "", password: "")
                }
            } else {
                // `apiVM.signupReturn`이 nil인 경우 처리할 로직을 작성합니다
            }
        })
        .onAppear(perform: {
            siderbarData.backPage = "loginView"
            withAnimation(.easeInOut(duration: 0.5)) {
                siderbarData.loginTitle = "sign_up_title"
            }
        })
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .environmentObject(SiderbarData())
    }
}
