//
//  IntroView.swift
//  juvee
//
//  Created by 이미연 on 2023/06/12.
//

import SwiftUI

struct IntroView: View {
    
    @State var introVisible: Bool = true
    
    var body: some View {
        if !introVisible {
            ContentView()
        } else {
            ZStack {
                Color(hex: 0xFF007A)
                VStack {
                    Image("intro_logo")
                    Image("smilewear_tm")
                }
                
                ZStack {
                    Image("intro1_3")
                        .offset(x: 20, y: -350)
                    Image("intro1_2")
                        .offset(x: 180, y: -130)
                    Image("intro1_1")
                        .offset(x: 130, y: -250)
                    
                    Image("intro2_1")
                        .offset(x: -130, y: -280)
                    
                    Image("intro3_1")
                        .offset(x: -130, y: -220)
                    
                    Image("intro4_1")
                        .offset(x: 153, y:100)
                    
                    
                }
                
                ZStack {
                    Image("intro4_2")
                        .offset(x: -250, y: 100)
                    Image("intro4_2")
                        .offset(x: -50, y: 300)
                }
                
                ZStack {
                    Image("intro3_1")
                        .offset(x: -85, y: 375)
                    Image("intro4_3")
                        .offset(x: -150, y: 410)
                    Image("intro4_2")
                        .offset(x: 30, y: 490)
                    Image("intro4_2")
                        .offset(x: -200, y: 260)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    introVisible = false
                }
            }
        }
    }
}


struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
