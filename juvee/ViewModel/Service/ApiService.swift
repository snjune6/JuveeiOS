//
//  ApiService.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import Foundation
import Combine

import Alamofire

enum ApiService {
    
    static func Login(dto: LoginDto) -> AnyPublisher<LoginRes, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.Login(dto: dto))
            .publishDecodable(type: LoginRes.self)
            .value()
            .mapError { error in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func SignUp(dto: SignUpDto) -> AnyPublisher<SignUpRes, AFError> {
        return ApiClient.shared.session
        .request(ApiRouter.SignUp(dto: dto))
        .publishDecodable(type: SignUpRes.self)
        .value()
        .mapError { error in
            if let afError = error as? AFError {
                return afError
            } else {
                return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    static func appleLogin(jwt: String, firstName: String, lastName: String) -> AnyPublisher<AppleLoginRes, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.appleLogin(jwt: jwt, firstName: firstName, lastName: lastName))
            .publishDecodable(type: AppleLoginRes.self)
            .value()
            .mapError { error in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
                }
            }.eraseToAnyPublisher()
    }
    
    static func appleLogin2(jwt: String) -> AnyPublisher<AppleLoginRes, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.appleLogin2(jwt: jwt))
            .publishDecodable(type: AppleLoginRes.self)
            .value()
            .mapError { error in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func defaultAppleLoginCheck(email: String) -> AnyPublisher<DefaultLoginCheckDto, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.defaultLoginCheck(email: email, socialType: "apple"))
            .publishDecodable(type: DefaultLoginCheckDto.self)
            .value()
            .map { receviedValue in
                return receviedValue
            }.eraseToAnyPublisher()
    }
    
    static func hasOnlyAppleAccount(jwtToken: String) -> AnyPublisher<Int, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.hasOnlyAppleAccount(jwtToken: jwtToken))
            .publishDecodable(type: Int.self)
            .value()
            .map { receviedValue in
                return receviedValue
            }.eraseToAnyPublisher()
    }
    
    static func googleLogin(jwt: String) -> AnyPublisher<AppleLoginRes, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.googleLogin(jwt: jwt))
            .publishDecodable(type: AppleLoginRes.self)
            .value()
            .mapError { error in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
                }
            }.eraseToAnyPublisher()
    }
    
    static func withdrawal(reason: String) -> AnyPublisher<SignUpRes, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.withdrawal(reason: reason))
            .publishDecodable(type: SignUpRes.self)
            .value()
            .map { receviedValue in
                
                if receviedValue.code == "1" {
                    UserDefaultManager.shared.logout()
                }
                return receviedValue
            }.eraseToAnyPublisher()
    }
    
    static func alternateEmail(jwtToken: String, alternateEmail: String, password: String, firstName: String, lastName: String, socialType: String) -> AnyPublisher<AppleLoginRes, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.alternateEmail(jwtToken: jwtToken, alternateEmail: alternateEmail, password: password, firstName: firstName, lastName: lastName, socialType: socialType))
            .publishDecodable(type: AppleLoginRes.self)
            .value()
            .mapError { error in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
                }
            
            }.eraseToAnyPublisher()
    }
    
    static func getOrdersDetails(orderId: String) -> AnyPublisher<OrdersDetailsRes, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.getOrdersDetails(orderId: orderId))
            .publishDecodable(type: OrdersDetailsRes.self)
            .value()
            .map { receviedValue in
                return receviedValue
            }
            .eraseToAnyPublisher()
    }
    
    static func GetOrdersCnt() -> AnyPublisher<Int, AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.GetOrdersCnt)
            .publishDecodable(type: Int.self)
            .value()
            .mapError { error in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
                }
            
            }.eraseToAnyPublisher()
    }
    
    static func GetCountriesData() -> AnyPublisher<[CountriesRes], AFError> {
        return ApiClient.shared.session
            .request(ApiRouter.GetCountriesData)
            .publishDecodable(type: [CountriesRes].self)  
            .value()
            .mapError { error in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
                }
            
            }.eraseToAnyPublisher()
    }
    
    static func ProfileUpdate(dto: UserDetailDto) -> AnyPublisher<ResponseDto, AFError> {
            return ApiClient.shared.session
            .request(ApiRouter.ProfileUpdate(dto: dto))
                .publishDecodable(type: ResponseDto.self)
                .value()
                .mapError { error in
                    if let afError = error as? AFError {
                        return afError
                    } else {
                        return AFError.responseSerializationFailed(reason: .customSerializationFailed(error: error))
                    }
                
                }.eraseToAnyPublisher()
        }
}
