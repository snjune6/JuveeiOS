//
//  PopupView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/23.
//

import SwiftUI

struct PopupView: View {
    
    @EnvironmentObject var alertData: AlertData
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var appStateData: AppStateData
    @EnvironmentObject var apiVM: ApiVM
    
    @State var popupTitle: String = ""
    @State var popupContent: String = ""
    
    var body: some View {
        
        VStack {
            if self.alertData.alertNum == 1 {
                VStack(spacing: 0) {
                    HStack {
                        Text("\(popupTitle)")
                            .font(.system(size: 14))
                            .padding()
                        Spacer()
                        Image("x")
                            .padding()
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.alertData.showAlert = false
                                    self.alertData.alertMsg = ""
                                    self.alertData.alertNum = 0
                                    self.alertData.alertTitle = ""
                                }
                            }
                    }
                    Divider()
                }
                .background(Color.white)
                .zIndex(20)
                .frame(width: UIScreen.main.bounds.width - 32)
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("\(popupContent)")
                            .foregroundColor(.black)
                            .padding(.bottom)
                        
                    }
                    .padding()
                    Divider()
                }
                VStack {
                    HStack {
                        Spacer()
                        Text("OK")
                            .onTapGesture {
                                if let signupResponse = apiVM.signupReturn {
                                    if signupResponse.code == "1" {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            siderbarData.backPage = "dashboardView"
                                            siderbarData.isSiderVisible = false
                                            siderbarData.menuCode = "loginView"
                                            siderbarData.layoutGB = 0
                                            
                                            self.alertData.showAlert = false
                                            self.alertData.alertMsg = ""
                                            self.alertData.alertNum = 0
                                            self.alertData.alertTitle = ""
                                        }
                                    } else {
                                        UserDefaultManager.shared.setLoginData(userId: "", email: "", userAccessToken: "", userExpiresAt: "", password: "")
                                    }
                                }
                            }
                            .padding()
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width - 32)
                }
            } else if self.alertData.alertNum == 2 {
                VStack(spacing: 0) {
                    HStack {
                        Text("\(popupTitle)")
                            .font(.system(size: 14))
                            .padding()
                        Spacer()
                        Image("x")
                            .padding()
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.alertData.showAlert = false
                                    self.alertData.alertMsg = ""
                                    self.alertData.alertNum = 0
                                    self.alertData.alertTitle = ""
                                }
                            }
                    }
                    Divider()
                }
                .background(Color.white)
                .zIndex(20)
                .frame(width: UIScreen.main.bounds.width - 32)
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("\(popupContent)")
                            .foregroundColor(.black)
                            .padding(.bottom)
                        
                    }
                    .padding()
                    Divider()
                }
                VStack {
                    HStack {
                        Spacer()
                        Text("OK")
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    if let profileResponse = apiVM.profileUpdateRes {
                                        if profileResponse.code == "1" {
                                            siderbarData.backPage = ""
                                            siderbarData.isSiderVisible = false
                                            siderbarData.menuCode = "dashboardView"
                                            siderbarData.layoutGB = 1
                                            
                                            self.alertData.showAlert = false
                                            self.alertData.alertMsg = ""
                                            self.alertData.alertNum = 0
                                            self.alertData.alertTitle = ""
                                        }
                                    }
                                }
                            }
                            .padding()
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width - 32)
                }
            } else if self.alertData.alertNum == 5 {
                VStack(spacing: 0) {
                    HStack {
                        Text("\(popupTitle)")
                            .font(.system(size: 14))
                            .padding()
                        Spacer()
                        Image("x")
                            .padding()
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.alertData.showAlert = false
                                    self.alertData.alertMsg = ""
                                    self.alertData.alertNum = 0
                                    self.alertData.alertTitle = ""
                                }
                            }
                    }
                    Divider()
                }
                .background(Color.white)
                .zIndex(20)
                .frame(width: UIScreen.main.bounds.width - 32)
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("\(popupContent)")
                            .foregroundColor(.black)
                            .padding(.bottom)
                        
                    }
                    .padding()
                    Divider()
                }
                VStack {
                    HStack {
                        Spacer()
                        Text("Cancel")
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.alertData.showAlert = false
                                    self.alertData.alertMsg = ""
                                    self.alertData.alertNum = 0
                                    self.alertData.alertTitle = ""
                                }
                            }
                            .padding()
                        Spacer()
                        HStack(spacing: 0) {
                            Divider()
                        }
                        .frame(height: 40)
                        Spacer()
                        Text("To Integrate")
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    siderbarData.backPage = "dashboardView"
                                    siderbarData.isSiderVisible = false
                                    siderbarData.menuCode = "displaceSocialView"
                                    siderbarData.layoutGB = 0
                                    appStateData.loading = false
                                    
                                    self.alertData.showAlert = false
                                    self.alertData.alertMsg = ""
                                    self.alertData.alertNum = 0
                                    self.alertData.alertTitle = ""
                                }
                            }
                            .padding()
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width - 32)
                }
            } else {
                VStack(spacing: 0) {
                    HStack {
                        Text("\(popupTitle)")
                            .font(.system(size: 14))
                            .padding()
                        Spacer()
                        Image("x")
                            .padding()
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.alertData.showAlert = false
                                    self.alertData.alertMsg = ""
                                    self.alertData.alertNum = 0
                                    self.alertData.alertTitle = ""
                                }
                            }
                    }
                    Divider()
                }
                .background(Color.white)
                .zIndex(20)
                .frame(width: UIScreen.main.bounds.width - 32)
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("\(popupContent)")
                            .foregroundColor(.black)
                            .padding(.bottom)
                        
                    }
                    .padding()
                    
                }
                
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32)
        .background(Color.white)
        .cornerRadius(10)
        .onAppear(perform: {
            withAnimation(.easeInOut(duration: 0.5)) {
                popupTitle = self.alertData.alertTitle
                popupContent = self.alertData.alertMsg
            }
        })
        
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}
