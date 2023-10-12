//
//  ContentView.swift
//  ButtonStyle_SwiftUI
//
//  Created by min on 2023/09/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 30) {
            Button {
                print("button Action")
            } label: {
                Text("Tab")
                    .fontWeight(.bold)
            }
            .buttonStyle(MyButtonStyle(color: .blue, type: .tab))
            
            Button {
                print("button Action")
            } label: {
                Text("Long Click")
                    .fontWeight(.bold)
            }
            .buttonStyle(MyButtonStyle(color: .green, type: .long))
            
            Button {
                print("button Action")
            } label: {
                Text("Rotate")
                    .fontWeight(.bold)
            }
            .buttonStyle(MyRotateButtonStyle(color: .pink))
            
            Button {
                print("button Action")
            } label: {
                Text("Smaller")
                    .fontWeight(.bold)
            }
            .buttonStyle(MySmallerButtonStyle(color: .purple))
            
            Button {
                print("button Action")
            } label: {
                Text("Blur")
                    .fontWeight(.bold)
            }
            .buttonStyle(MyBlurButtonStyle(color: .black))

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
