//
//  ProfileView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/20.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var alertData: AlertData
    @EnvironmentObject var appStateData: AppStateData
    @EnvironmentObject var loginData: LoginData
    @EnvironmentObject var apiVM: ApiVM
    
    @State var emailInput: String = UserDefaultManager.shared.getLoginData().email
    @State var passwordInput: String = ""
    @State var corfirmPasswordInput: String = ""
    @State var firstNameInput: String = UserDefaultManager.shared.getUserDetail()!.firstName
    @State var lastNameInput: String = UserDefaultManager.shared.getUserDetail()!.lastName
    
    @State var countryInput: String = UserDefaultManager.shared.getUserDetail()!.country
    @State var addressInput: String = UserDefaultManager.shared.getUserDetail()!.address1
    @State var cityInput: String = UserDefaultManager.shared.getUserDetail()!.city
    @State var stateInput: String = UserDefaultManager.shared.getUserDetail()!.provinceCode
    @State var stateNameInput: String = ""
    @State var zipInput: String = UserDefaultManager.shared.getUserDetail()!.zip
    
    @State var genderInput: String = UserDefaultManager.shared.getUserDetail()!.gender
    @State var birthDayInput: String = UserDefaultManager.shared.getUserDetail()!.birthDay
    @State var phoneNumberInput: String = UserDefaultManager.shared.getUserDetail()!.phone
    
    @State var notifications: Bool = UserDefaultManager.shared.getUserDetail()!.notifications
    @State var termInput: Bool = true
    @State var privacyInput: Bool = true
    
    @State var popupVisible: Bool = false
    @State var popupGB: Int = 0
    
    @State var countryNameArr1: [String] = []
    @State var countryCodeArr1: [String] = []
    @State var countryArrayIdx: [Int] = []
    
    var userDetailDto = UserDetailDto()
    
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
                    
                    if self.loginData.socialType.isEmpty {
                        VStack {
                            Text("Change Password")
                                .bold()
                                .frame(maxWidth: UIScreen.main.bounds.width - 64)
                                .padding()
                        }
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .padding(.vertical)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.siderbarData.backPage = "profileView"
                                self.siderbarData.isSiderVisible = false
                                self.siderbarData.layoutGB = 0
                                self.siderbarData.loginTitle = "password_change_title"
                                self.siderbarData.menuClick = true
                                self.siderbarData.menuCode = "passwordChangeView"
                                print("sider : \(siderbarData.menuCode)")
                            }
                        }
                    }
                    
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
                        Text("Shipping Info")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .bold))
                        Spacer()
                    }
                    ZStack(alignment: .leading) {
                        Text("Country")
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -35)
                        Picker(selection: $countryInput, label: Text("Picker").foregroundColor(.black).font(.system(size: 16))) {
                            Text("United States").tag(1)
                        }
                        .frame(width: UIScreen.main.bounds.width - 56, height: 40, alignment: .center)
                    }
                    .background(.white)
                    
                    ZStack(alignment: .leading) {
                        Text("Address")
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -35)
                        TextField("", text: $addressInput)
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
                        ZStack(alignment: .leading) {
                            
                            Text("City")
                                .font(.caption)
                                .foregroundColor(.white)
                                .offset(y: -35)
                            TextField("", text: $cityInput)
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
                            
                            Text("State")
                                .font(.caption)
                                .foregroundColor(.white)
                                .offset(y: -35)
                            
                            Picker(selection: $stateInput, label: Text("Picker").foregroundColor(.black).font(.system(size: 16))) {
                                //Text("1").tag(1)
                                ForEach(0 ..< $countryNameArr1.count, id: \.self) {
                                    Text("\(self.countryNameArr1[$0])")
                                        .tag(self.countryCodeArr1[$0])
                                }
                            }
                            .frame(height: 40, alignment: .center)
                            //.padding(.horizontal, 40)
                            .onAppear(perform: {
                                self.apiVM.GetCountriesData()
                            })
                            .onReceive(self.apiVM.getCountriesDataSuccess, perform: {
                                countryNameArr1 = self.apiVM.countryNameArr1
                                countryCodeArr1 = self.apiVM.countryCodeArr1
                                countryArrayIdx = self.apiVM.countryArrayIdx
                            })
                        }
                        .background(.white)
                        .padding(.top, 24)
                    }
                    
                    ZStack(alignment: .leading) {
                        Text("Zip Code")
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -35)
                        TextField("", text: $zipInput)
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
                        
                        
                        var userDetailDto = UserDetailDto()
                        
                        userDetailDto.firstName = firstNameInput
                        userDetailDto.lastName = lastNameInput
                        userDetailDto.country = "United States"
                        userDetailDto.countryCode = "US"
                        userDetailDto.address1 = addressInput
                        userDetailDto.city = cityInput
                        if let index = countryCodeArr1.firstIndex(of: stateInput) {
                            userDetailDto.province = countryNameArr1[index]
                        }
                        
                        userDetailDto.provinceCode = stateInput
                        userDetailDto.zip = zipInput
                        userDetailDto.gender = genderInput
                        userDetailDto.birthDay = birthDayInput
                        userDetailDto.phone = phoneNumberInput
                        userDetailDto.notifications = notifications
                        
                        print(userDetailDto)
                        apiVM.ProfileUpdate(userDetail: userDetailDto)
                    }, label: {
                        Image("update_btn")
                            .padding()
                            .frame(maxWidth: UIScreen.main.bounds.width - 64)
                    })
                    .background(.black)
                    .cornerRadius(50)
                    .padding(.top, 32)
                    
                    Image("cancel_btn")
                        .padding()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.siderbarData.backPage = ""
                                self.siderbarData.isSiderVisible = false
                                self.siderbarData.menuCode = "dashboardView"
                                self.siderbarData.layoutGB = 1
                            }
                        }
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
        .onReceive(apiVM.profileUpdateSuccess, perform: {
            
            if let profileRes = apiVM.profileUpdateRes {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.alertData.alertMsg = profileRes.message
                    self.alertData.alertNum = 2
                    self.alertData.alertTitle = "PROFILE UPDATE"
                    self.alertData.showAlert = true
                }
                
                
            }
            
        })
        .onAppear(perform: {
            
            siderbarData.backPage = "dashboardView"
            withAnimation(.easeInOut(duration: 0.5)) {
                siderbarData.loginTitle = "profile_title"
            }
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
    
