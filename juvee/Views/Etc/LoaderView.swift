//
//  LoaderView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI

struct LoaderView: View {
    @State var spinCircle = false
        
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+50)
                .background(Color(.init(red: 255 / 255, green: 0 / 255, blue: 122 / 255, alpha: 0.5)))
                .cornerRadius(8)
                .opacity(0.6)
                
            Rectangle().frame(width:160, height: 135).background(Color.black).cornerRadius(8).opacity(0.6).shadow(color: .black, radius: 16)
            VStack {
                Circle()
                    .trim(from: 0.3, to: 1)
                    .stroke(Color.white, lineWidth: 3)
                    .frame(width: 40, height: 40)
                    .padding(.all, 8)
                    .rotationEffect(.degrees(spinCircle ? 0 : -360), anchor: .center)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false)) {
                            self.spinCircle = true
                        }
                    }
                Text("Please wait...").foregroundColor(.white)
            }
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
