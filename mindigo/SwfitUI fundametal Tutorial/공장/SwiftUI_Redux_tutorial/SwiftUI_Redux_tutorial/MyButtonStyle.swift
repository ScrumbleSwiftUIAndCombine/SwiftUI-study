//
//  MyButtonStyle.swift
//  SwiftUI_Redux_tutorial
//
//  Created by min on 2023/10/04.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 20))
            .padding()
            .background(.orange)
            .foregroundColor(.white)
            .cornerRadius(20)
    }
}

struct MyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            //
        } label: {
            Text("안녕")
        }.buttonStyle(MyButtonStyle())

    }
}

