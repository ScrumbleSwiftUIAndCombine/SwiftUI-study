//
//  MyBlurButtonStyle.swift
//  ButtonStyle_SwiftUI
//
//  Created by min on 2023/09/26.
//

import SwiftUI

struct MyBlurButtonStyle: ButtonStyle {
    
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 20))
            .foregroundColor(.white)
            .padding()
            .background(color)
            .cornerRadius(20)
            .blur(radius: configuration.isPressed ? 10 : 0)
    }
}

struct MyBlurButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("탭") {
            print("탭")
        }.buttonStyle(MyBlurButtonStyle(color: .blue))
    }
}


