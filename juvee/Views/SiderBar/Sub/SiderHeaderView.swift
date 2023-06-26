//
//  SiderHeaderView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI

struct SiderHeaderView: View {
    
    @EnvironmentObject var siderbarData: SiderbarData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: {
                    siderbarData.isSiderVisible.toggle()
                }, label: {
                    Image("icon_Closed")
                })
                Spacer()
                Image("logo")
            }
            Divider()
        }
        .padding(.top, 70)
        .padding(.horizontal, 20)
    }
}

struct SiderHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SiderHeaderView()
    }
}
