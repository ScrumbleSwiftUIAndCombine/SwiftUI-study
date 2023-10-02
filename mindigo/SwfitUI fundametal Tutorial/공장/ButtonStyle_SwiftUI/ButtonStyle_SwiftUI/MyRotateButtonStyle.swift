//
//  MyRotateButtonStyle.swift
//  ButtonStyle_SwiftUI
//
//  Created by min on 2023/09/26.
//

import SwiftUI

struct MyRotateButtonStyle: ButtonStyle {
    
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 20))
            .foregroundColor(.white)
            .padding()
            .background(color)
            .cornerRadius(20)
            .rotationEffect(configuration.isPressed ? .degrees(98) : .degrees(0))
    }
}

struct MyRotateButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("탭") {
            print("탭")
        }.buttonStyle(MyRotateButtonStyle(color: .blue))
    }
}


