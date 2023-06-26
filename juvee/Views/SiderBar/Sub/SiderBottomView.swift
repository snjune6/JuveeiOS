//
//  SiderBottomView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI

struct SiderBottomView: View {
    var body: some View {
        VStack {
            HStack {
                Image("Instagram")
                Image("YouTube")
                Spacer()
                Image("ver.1.0.1")
            }
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Image("copylite")
                }
                Spacer()
                HStack(spacing: 0) {
                    Divider()
                }
                .frame(height: 40)
                Spacer()
                Image("e32")
                Spacer()
            }
            .padding(.bottom, 10)
        }
        .padding(.top, 70)
        .padding(.horizontal, 20)
    }
}

struct SiderBottomView_Previews: PreviewProvider {
    static var previews: some View {
        SiderBottomView()
    }
}
