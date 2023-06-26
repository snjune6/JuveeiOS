//
//  IntegratedVIew.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI

struct IntegratedVIew: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    @EnvironmentObject var alertData: AlertData
    @EnvironmentObject var loginData: LoginData
    
    var body: some View {
        if siderbarData.layoutGB == 0 {
            
            LoginLayout()
            
        } else {
            
            CommonLayout()
            
        }
    }
}

struct IntegratedVIew_Previews: PreviewProvider {
    static var previews: some View {
        IntegratedVIew()
    }
}
