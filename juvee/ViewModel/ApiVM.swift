//
//  ApiVM.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation
import Combine
import Alamofire

class ApiVM: ObservableObject {
    
    var subscription = Set<AnyCancellable>()
    var alertData = AlertData()
    var loginData = LoginData()
    var siderbarData = SiderbarData()
    var appStateData = AppStateData()

    
    // login
    @Published var loginReturn: UserDto? = nil
    @Published var tokenReturn: TokenDto? = nil
    var loginSuccess = PassthroughSubject<(), Never>()
    
    // signup
    @Published var signupReturn: SignUpRes? = nil
    var signupSuccess = PassthroughSubject<(), Never>()
    
    // appleLogin
    @Published var appleLoginReturn: AppleUserDto? = nil
    @Published var defaultAppleLoginCheckReturn: DefaultLoginCheckDto? = nil
    var appleSocialLoginSuccess = PassthroughSubject<(), Never>()
    let defaultAppleLoginCheckSuccess = PassthroughSubject<(), Never>()

    @Published var onlyAppleAccount: Int  = 0
    let onlyAppleAccountSuccess = PassthroughSubject<(), Never>()
    
    @Published var googleLoginReturn: AppleUserDto? = nil
    var googleSocialLoginSuccess = PassthroughSubject<(), Never>()
    
    // 회원탈퇴
    @Published var withdrawalReturn: SignUpRes? = nil
    let withdrawalSuccess = PassthroughSubject<(), Never>()
    
    // 오더리스트
    var ordersListSuccess = PassthroughSubject<(), Never>()
    @Published var ordersListReturn: OrdersListRes? = nil
    @Published var lastOrderReturn: OrdersDto? = nil
    
    // 오더리스트
    var ordersListSuccess2 = PassthroughSubject<(), Never>()
    @Published var ordersListReturn2: OrdersListRes? = nil
    @Published var lastOrderReturn2: OrdersDto? = nil
    
    // 오더디테일
    @Published var getOrdersDetailsReturn: OrdersDetailsDto? = nil
    @Published var getOrdersDetailsListReturn: [HistoryDto]? = nil
    var ordersDetailsSuccess = PassthroughSubject<(), Never>()
    
    // 오더개수
    @Published var getOrdersCnt: Int = 0
    var getOrdersCntSuccess = PassthroughSubject<(), Never>()
    
    // state목록조회
    @Published var getCountriesDataReturn: [CountriesRes]? = nil
    var getCountriesDataSuccess = PassthroughSubject<(), Never>()
    @Published var countryNameArr1: [String] = []
    @Published var countryCodeArr1: [String] = []
    @Published var countryArrayIdx: [Int] = []
    
    
    @Published var profileUpdateRes: ResponseDto? = nil
    var profileUpdateSuccess = PassthroughSubject<(), Never>()
    
    func Login(dto: LoginDto) {
        ApiService.Login(dto: dto)
            .sink { (completion:Subscribers.Completion<AFError>) in
                switch completion {
                case .failure(let error):
                    self.alertData.alertMsg = "통신 실패 : \(error.localizedDescription)"
                    self.alertData.alertNum = 1
                    self.alertData.showAlert = true
                case .finished:
                    break
                }
            } receiveValue: { (receivedUser: LoginRes) in
                
                if receivedUser.user.error == "1" {
                    UserDefaultManager.shared.setLoginData(
                        userId: receivedUser.user.id,
                        email: receivedUser.user.email,
                        userAccessToken: receivedUser.token.accessToken,
                        userExpiresAt: receivedUser.token.expiresAt,
                        password: receivedUser.user.password
                    )
                    UserDefaultManager.shared.setUserDetail(userDetailDto: receivedUser.userDetail)
                    
                    UserDefaultManager.shared.setUserName(userName: "\(receivedUser.userDetail.firstName) \(receivedUser.userDetail.lastName)")
                    UserDefaultManager.shared.setLastOrderNo(lastOrderNo: receivedUser.userDetail.orderNo)
                    UserDefaultManager.shared.setLastOrderAt(lastOrderAt: receivedUser.userDetail.orderCreateAt)
                    
                    UserDefaultManager.shared.setLoginYN(loginYN: true)
                    UserDefaultManager.shared.setApiKey(apiKey: receivedUser.token.accessToken)
                } else {
                    self.alertData.showAlert = true
                    self.alertData.alertMsg = receivedUser.user.errorMsg
                    self.alertData.alertNum = 1
                    
                    UserDefaultManager.shared.logout()
                }
                
                
                self.loginData.loginYn = UserDefaultManager.shared.getLoginYN()
                
                self.loginReturn = receivedUser.user
                self.tokenReturn = receivedUser.token
                self.loginSuccess.send()
            }
            .store(in: &subscription)
    }
    
    func signUp(dto: SignUpDto) {
        
        ApiService.SignUp(dto: dto)
            .sink { (completion:Subscribers.Completion<AFError>) in
                switch completion {
                case .failure(let error):
                    self.alertData.alertMsg = "통신 실패 : \(error.localizedDescription)"
                    self.alertData.alertNum = 1
                    self.alertData.showAlert = true
                case .finished:
                    break
                }
            } receiveValue: { (receivedUser: SignUpRes) in
                self.signupReturn = receivedUser
                self.signupSuccess.send()
            }.store(in: &subscription)
    }
    
    func appleLogin(jwt: String, firstName: String, lastName: String) {
            
        ApiService.appleLogin(jwt: jwt, firstName: firstName, lastName: lastName)
            .sink { (completion:Subscribers.Completion<AFError>) in
                print("ApiVM completion: \(completion)")
            } receiveValue: { (receivedUser: AppleLoginRes) in
                
                if receivedUser.user.error == "1" {
                    UserDefaultManager.shared.setLoginData(
                        userId: receivedUser.user.id,
                        email: receivedUser.user.email,
                        userAccessToken: receivedUser.token.accessToken,
                        userExpiresAt: receivedUser.token.expiresAt,
                        password: receivedUser.user.password
                    )
                    UserDefaultManager.shared.setAppleNumber(appleNumber: receivedUser.user.socialId)
                    UserDefaultManager.shared.setLoginDataSocial(tag: "apple")
                    UserDefaultManager.shared.setUserName(userName: "\(receivedUser.userDetail.firstName) \(receivedUser.userDetail.lastName)")
                    UserDefaultManager.shared.setLastOrderNo(lastOrderNo: receivedUser.userDetail.orderNo)
                    UserDefaultManager.shared.setLastOrderAt(lastOrderAt: receivedUser.userDetail.orderCreateAt)
                    
                    UserDefaultManager.shared.setLoginYN(loginYN: true)
                    UserDefaultManager.shared.setApiKey(apiKey: receivedUser.token.accessToken)
                    
                    
                    self.loginData.loginYn = true
                    self.loginData.accesstoken = receivedUser.token.accessToken
                } else {
                    self.alertData.showAlert = true
                    self.alertData.alertMsg = receivedUser.user.errorMsg
                    self.alertData.alertNum = 1
                    self.loginData.loginYn = false
                    self.loginData.accesstoken = ""
                }
                
                self.appleLoginReturn = receivedUser.user
                self.tokenReturn = receivedUser.token
                self.appleSocialLoginSuccess.send()
            }
            .store(in: &subscription)
        
    }
    
    func appleLogin2(jwt: String) {
        
        ApiService.appleLogin2(jwt: jwt)
            .sink { (completion:Subscribers.Completion<AFError>) in
                print("ApiVM completion: \(completion)")
            } receiveValue: { (receivedUser: AppleLoginRes) in
                if receivedUser.user.error == "1" {
                    UserDefaultManager.shared.setLoginData(
                        userId: receivedUser.user.id,
                        email: receivedUser.user.email,
                        userAccessToken: receivedUser.token.accessToken,
                        userExpiresAt: receivedUser.token.expiresAt,
                        password: receivedUser.user.password
                    )
                    UserDefaultManager.shared.setAppleNumber(appleNumber: receivedUser.user.socialId)
                    UserDefaultManager.shared.setLoginDataSocial(tag: "apple")
                    UserDefaultManager.shared.setUserName(userName: "\(receivedUser.userDetail.firstName) \(receivedUser.userDetail.lastName)")
                    UserDefaultManager.shared.setLastOrderNo(lastOrderNo: receivedUser.userDetail.orderNo)
                    UserDefaultManager.shared.setLastOrderAt(lastOrderAt: receivedUser.userDetail.orderCreateAt)
                    
                    UserDefaultManager.shared.setLoginYN(loginYN: true)
                    UserDefaultManager.shared.setApiKey(apiKey: receivedUser.token.accessToken)
                    
                    
                    self.loginData.loginYn = true
                    self.loginData.accesstoken = receivedUser.token.accessToken
                } else {
                    self.alertData.showAlert = true
                    self.alertData.alertMsg = receivedUser.user.errorMsg
                    self.alertData.alertNum = 1
                    self.loginData.loginYn = false
                    self.loginData.accesstoken = ""
                }
                
                self.appleLoginReturn = receivedUser.user
                self.tokenReturn = receivedUser.token
                self.appleSocialLoginSuccess.send()
            }
            .store(in: &subscription)
    }
    
    func defaultAppleLoginCheck(email: String) {
        ApiService.defaultAppleLoginCheck(email: email)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("ApiVM defaultAppleLoginCheck : \(completion)")
            } receiveValue: { (receivedReturn: DefaultLoginCheckDto) in
                self.defaultAppleLoginCheckReturn = receivedReturn
                self.defaultAppleLoginCheckSuccess.send()
            }.store(in: &subscription)
    }
    
    // 애플 아이디 존재 여부
    func hasOnlyAppleAccount(jwtToken: String) {
        ApiService.hasOnlyAppleAccount(jwtToken: jwtToken)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("ApiVM hasAppleAccount : \(completion)")
            } receiveValue: { (receivedReturn: Int) in
                self.onlyAppleAccount = receivedReturn
                self.onlyAppleAccountSuccess.send()
            }.store(in: &subscription)
    }
    
    func googleLogin(jwt: String) {
            
        ApiService.googleLogin(jwt: jwt)
            .sink { (completion:Subscribers.Completion<AFError>) in
                print("ApiVM completion: \(completion)")
            } receiveValue: { (receivedUser: AppleLoginRes) in
                
                if receivedUser.user.error == "1" {
                    UserDefaultManager.shared.setLoginData(
                        userId: receivedUser.user.id,
                        email: receivedUser.user.email,
                        userAccessToken: receivedUser.token.accessToken,
                        userExpiresAt: receivedUser.token.expiresAt,
                        password: receivedUser.user.password
                    )
                    UserDefaultManager.shared.setAppleNumber(appleNumber: receivedUser.user.socialId)
                    UserDefaultManager.shared.setLoginDataSocial(tag: "google")
                    UserDefaultManager.shared.setUserName(userName: "\(receivedUser.userDetail.firstName) \(receivedUser.userDetail.lastName)")
                    UserDefaultManager.shared.setLastOrderNo(lastOrderNo: receivedUser.userDetail.orderNo)
                    UserDefaultManager.shared.setLastOrderAt(lastOrderAt: receivedUser.userDetail.orderCreateAt)
                    
                    UserDefaultManager.shared.setLoginYN(loginYN: true)
                    UserDefaultManager.shared.setApiKey(apiKey: receivedUser.token.accessToken)
                    
                    
                    self.loginData.loginYn = true
                    self.loginData.accesstoken = receivedUser.token.accessToken
                    self.loginData.socialType = "google"
                } else if receivedUser.user.error == "11" {
                    self.loginData.socialType = "google"
                } else {
                    self.alertData.showAlert = true
                    self.alertData.alertMsg = receivedUser.user.errorMsg
                    self.alertData.alertNum = 1
                    self.loginData.loginYn = false
                    self.loginData.accesstoken = ""
                }
                
                self.googleLoginReturn = receivedUser.user
                self.tokenReturn = receivedUser.token
                self.googleSocialLoginSuccess.send()
            }
            .store(in: &subscription)
    }
    
    func withdrawal(reason: String) {
        ApiService.withdrawal(reason: reason)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("ApiVM withdrawal : \(completion)")
            } receiveValue: { (receivedReturn: SignUpRes) in
                self.withdrawalReturn = receivedReturn
                self.withdrawalSuccess.send()
            }
            .store(in: &subscription)
    }
    
    // 애플 아이디 숨김 대체아이디
    func alternateEmail(jwtToken: String, alternateEmail: String, password: String, firstName: String, lastName: String, socialType: String) {
        ApiService.alternateEmail(jwtToken: jwtToken, alternateEmail: alternateEmail, password: password, firstName: firstName, lastName: lastName, socialType: socialType)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("ApiVM alternateEmail : \(completion)")
                switch completion {
                case .failure(let error):
                    self.alertData.alertMsg = "\(error.localizedDescription)"
                    self.alertData.alertTitle = "Communication Failure"
                    self.alertData.showAlert = true
                case .finished:
                    break
                }
            } receiveValue: { (receivedReturn: AppleLoginRes) in
                        
                if receivedReturn.user.error == "1" {
                    UserDefaultManager.shared.setLoginData(
                        userId: receivedReturn.user.id,
                        email: receivedReturn.user.email,
                        userAccessToken: receivedReturn.token.accessToken,
                        userExpiresAt: receivedReturn.token.expiresAt,
                        password: receivedReturn.user.password
                    )
                    UserDefaultManager.shared.setAppleNumber(appleNumber: receivedReturn.user.socialId)
                    UserDefaultManager.shared.setLoginDataSocial(tag: socialType)
                    UserDefaultManager.shared.setUserName(userName: "\(receivedReturn.userDetail.firstName) \(receivedReturn.userDetail.lastName)")
                    UserDefaultManager.shared.setLastOrderNo(lastOrderNo: receivedReturn.userDetail.orderNo)
                    UserDefaultManager.shared.setLastOrderAt(lastOrderAt: receivedReturn.userDetail.orderCreateAt)
                    
                    UserDefaultManager.shared.setLoginYN(loginYN: true)
                    UserDefaultManager.shared.setApiKey(apiKey: receivedReturn.token.accessToken)
                    
                    
                    self.loginData.loginYn = true
                    self.loginData.accesstoken = receivedReturn.token.accessToken
                } else {
                    self.loginData.loginYn = false
                    self.loginData.accesstoken = ""
                }
                
                self.appleLoginReturn = receivedReturn.user
                self.tokenReturn = receivedReturn.token
                self.appleSocialLoginSuccess.send()
                
            }.store(in: &subscription)
    }
    
    func getOrderList(gbcd: Int, currentPage: Int) {
            
        var headers = HTTPHeaders();
        headers["newApiKey"] = UserDefaultManager.shared.getApiKey()
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        
        var params = Parameters()
        params["apiName"] = "shopify"
        params["userId"] = UserDefaultManager.shared.getLoginData().userId
        params["email"] = UserDefaultManager.shared.getLoginData().email
        params["gbcd"] = gbcd
        params["currentPage"] = currentPage
        
        print("ApiService - getOrderList() called!")
        
        let url = ApiClient.BASE_URL + "/api/getOrdersList"
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: OrdersListRes.self) { (response) in
                if gbcd == 1 {
                    guard let orderListRes = response.value else { return }
                    self.ordersListReturn = orderListRes
                    if orderListRes.ordersCnt != 0 {
                        self.lastOrderReturn = orderListRes.all[0]
                    }
                    
                    self.ordersListSuccess.send()
                } else {
                    guard let orderListRes = response.value else { return }
                    self.ordersListReturn2 = orderListRes
                    if orderListRes.ordersCnt != 0 {
                        self.lastOrderReturn2 = orderListRes.all[0]
                    }
                    
                    self.ordersListSuccess2.send()
                }
            }
    }
    
    func getOrdersDetails(orderId: String) {
        ApiService.getOrdersDetails(orderId: orderId)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("ApiVM completion : \(completion)")
            } receiveValue: { (receivedReturn: OrdersDetailsRes) in
                self.getOrdersDetailsReturn = receivedReturn.all
                self.getOrdersDetailsListReturn = receivedReturn.history
                self.ordersDetailsSuccess.send()
            }.store(in: &subscription)
    }
    
    func GetOrdersCnt() {
        ApiService.GetOrdersCnt()
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("ApiVM completion: \(completion)")
            } receiveValue: { (receivedReturn: Int) in
                self.getOrdersCnt = receivedReturn
                self.getOrdersCntSuccess.send()
            }
            .store(in: &subscription)
    }
    
    func GetCountriesData() {
        
        ApiService.GetCountriesData()
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("ApiVM completion: \(completion)")
            } receiveValue: { (receivedReturn: [CountriesRes]) in
                
                self.countryNameArr1.removeAll()
                self.countryCodeArr1.removeAll()
                
                
                var i: Int = 0
                for data in receivedReturn {
                    for datas in data.provinceDto {
                        self.countryNameArr1.append(datas.name)
                        self.countryCodeArr1.append(datas.code)
                        self.countryArrayIdx.append(i)
                    }
                    
                }
                
                
                self.getCountriesDataReturn = receivedReturn
                self.getCountriesDataSuccess.send()
                
            }
            .store(in: &subscription)
    }
    
    func ProfileUpdate(userDetail: UserDetailDto) {
        ApiService.ProfileUpdate(dto: userDetail)
                .sink { (completion: Subscribers.Completion<AFError>) in
                    print("ApiVM profileDataUpdate : \(completion)")
                } receiveValue: { (receivedReturn: ResponseDto) in
                    self.profileUpdateRes = receivedReturn
                    
                    if self.profileUpdateRes?.code == "1" {
                        UserDefaultManager.shared.setUserDetail(userDetailDto: userDetail)
                    }
                    self.profileUpdateSuccess.send()
                }.store(in: &subscription)
        }
}
