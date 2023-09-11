//
//  MyStackView.swift
//  Image_tutorial
//
//  Created by min on 2023/09/11.
//

import SwiftUI

struct MyStackView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.red)
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.yellow)
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.blue)
        }
        .background(Color.green)
//        .edgesIgnoringSafeArea(.all)
    }
}

struct MyStackView_Previews: PreviewProvider {
    static var previews: some View {
        MyStackView()
    }
}
