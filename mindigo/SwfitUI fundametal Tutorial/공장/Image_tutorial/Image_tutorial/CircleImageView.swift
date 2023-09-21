//
//  CircleImageView.swift
//  Image_tutorial
//
//  Created by min on 2023/09/11.
//

import SwiftUI

struct CircleImageView: View {
    var body: some View {
//        Image(systemName: "flame.fill")
//            .font(.system(size: 200))
//            .foregroundColor(.red)
//            .shadow(color: .gray, radius: 10, x: 10, y: 10)
        
        Image("myImage")
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 300)
//            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .shadow(color: .gray, radius: 10, x: 10, y: 10)
            .overlay(Circle().foregroundColor(.black).opacity(0.5))
            .overlay(
                Circle().stroke(Color.blue, lineWidth: 5)
                    .padding()
            )
            .overlay(
                Circle().stroke(Color.yellow, lineWidth: 5)
                    .padding(30)
            )
            .overlay(
                Circle().stroke(Color.red, lineWidth: 5)
            )
            .overlay(
                Text("Hello")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
            )
//            .edgesIgnoringSafeArea(.all)
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView()
    }
}
