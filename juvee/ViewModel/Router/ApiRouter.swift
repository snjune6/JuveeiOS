//
//  ApiRouter.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case Login(dto: LoginDto)
    case SignUp(dto: SignUpDto)
    case appleLogin(jwt: String, firstName: String, lastName: String), appleLogin2(jwt: String)
    case defaultLoginCheck(email: String, socialType: String)
    case hasOnlyAppleAccount(jwtToken: String)
    case googleLogin(jwt: String)
    case withdrawal(reason: String)
    case alternateEmail(jwtToken: String, alternateEmail: String, password: String, firstName: String, lastName: String, socialType: String)
    case getOrdersDetails(orderId: String)
    case GetOrdersCnt
    case GetCountriesData
    case ProfileUpdate(dto: UserDetailDto)
    
    
    var baseUrl: URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
        case .Login:
            return "auth/v2/login"
        case .SignUp:
            return "auth/signup"
        case .appleLogin:
            return "auth/apple_login"
        case .appleLogin2:
            return "auth/apple_login"
        case .defaultLoginCheck:
            return "auth/default_login_check"
        case .hasOnlyAppleAccount:
            return "auth/hasOnlyAppleAccount"
        case .googleLogin:
            return "auth/google_login"
        case .withdrawal:
            return "auth/withdrawal"
        case .alternateEmail:
            return "auth/alternateEmail"
        case .getOrdersDetails:
            return "api/getOrdersDetails"
        case .GetOrdersCnt:
            return "api/get_orders_cnt"
        case .GetCountriesData:
            return "/api/getCountries"
        case .ProfileUpdate:
            return "auth/updateUserDetailToiOS"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .GetOrdersCnt:
            return .get
        case .GetCountriesData:
            return .get
        default: return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .Login(dto):
            var params = Parameters()
            params["email"] = dto.email
            params["password"] = dto.password
            params["socialType"] = UserDefaultManager.shared.getLoginDataSocial()
            
            return params
        case let .SignUp(dto):
            var params = Parameters()
            params["apiName"] = "shopify"
            
            params["email"] = dto.email
            params["password"] = dto.password
            params["firstName"] = dto.firstName
            params["lastName"] = dto.lastName
            
            params["gender"] = dto.gender
            params["birthDay"] = dto.birthDay
            params["cellNumber"] = dto.phoneNumber
            
            params["notifications"] = dto.notifications
            
            return params
        case let .appleLogin(jwt, firstName, lastName):
            var params = Parameters()
            params["jwt"] = jwt
            params["firstName"] = firstName
            params["lastName"] = lastName
            params["socialType"] = "apple"
            
            return params
        case let .appleLogin2(jwt):
            var params = Parameters()
            params["jwt"] = jwt
            params["socialType"] = "apple"
            
            return params
        case let .defaultLoginCheck(email, socialType):
            var params = Parameters()
            params["email"] = email
            params["socialType"] = socialType
            
            
            return params
        case let .hasOnlyAppleAccount(jwtToken):
            var params = Parameters()
            params["jwtToken"] = jwtToken
            
            return params
        case let .googleLogin(jwt):
            var params = Parameters()
            params["jwt"] = jwt
            params["socialType"] = "google"
            
            return params
        case let .withdrawal(reason):
            var params = Parameters()
            params["email"] = UserDefaultManager.shared.getLoginData().email
            params["withdrawalReason"] = reason
            params["socialType"] = UserDefaultManager.shared.getLoginDataSocial()
            
            return params
        case let .alternateEmail(jwtToken, alternateEmail, password, firstName, lastName, socialType):
            var params = Parameters()
            params["jwtToken"] = jwtToken
            params["alternateEmail"] = alternateEmail
            params["password"] = password
            params["firstName"] = firstName
            params["lastName"] = lastName
            params["socialType"] = socialType
            
            return params
        case let .getOrdersDetails(orderId):
            var params = Parameters()
            params["email"] = UserDefaultManager.shared.getLoginData().email
            params["orderNo"] = orderId
            params["socialType"] = UserDefaultManager.shared.getLoginDataSocial()
            
            return params
        case .GetOrdersCnt:
            let parameters: Parameters = [
                "email": UserDefaultManager.shared.getLoginData().email
            ]
            
            return parameters
        case .GetCountriesData:
            let parameters: Parameters = [
                "apiName": "shopify"
            ]
            
            return parameters
        case let .ProfileUpdate(dto):
            let parameters: Parameters = [
                "email": UserDefaultManager.shared.getLoginData().email,
                "firstName": dto.firstName,
                "lastName": dto.lastName,
                "country": dto.country,
                "countryCode": dto.countryCode,
                "address1": dto.address1,
                "city": dto.city,
                "province": dto.province,
                "provinceCode": dto.provinceCode,
                "zip": dto.zip,
                "gender": dto.gender,
                "birthDay": dto.birthDay,
                "phone": dto.phone
            ]
            
            return parameters
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)
        
        var headers = HTTPHeaders()
        headers["newApiKey"] = UserDefaultManager.shared.getApiKey()
        
        var request = URLRequest(url: url)
        request.headers = headers
        request.method = method
        switch self.method {
        case .get:
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: value as! String)
                queryItems.append(queryItem)
            }
            urlComponents?.queryItems = queryItems
            request.url = urlComponents?.url
        default:
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        }
        
        return request
    }
}
