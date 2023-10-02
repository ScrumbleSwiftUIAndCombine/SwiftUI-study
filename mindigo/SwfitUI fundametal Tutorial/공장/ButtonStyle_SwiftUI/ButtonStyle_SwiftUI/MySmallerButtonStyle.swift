//
//  MySmallerButtonStyle.swift
//  ButtonStyle_SwiftUI
//
//  Created by min on 2023/09/26.
//

import SwiftUI

struct MySmallerButtonStyle: ButtonStyle {
    
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 20))
            .foregroundColor(.white)
            .padding()
            .background(color)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct MySmallerButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("탭") {
            print("탭")
        }.buttonStyle(MySmallerButtonStyle(color: .blue))
    }
}



