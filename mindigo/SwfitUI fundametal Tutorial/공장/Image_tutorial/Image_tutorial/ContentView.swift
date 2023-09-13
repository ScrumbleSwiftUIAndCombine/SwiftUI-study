//
//  ContentView.swift
//  Image_tutorial
//
//  Created by min on 2023/09/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("myImage")
                    .frame(height: 10)
                    .offset(x: 0, y: -200)
                
                CircleImageView()
                
                HStack {
                    NavigationLink {
                        MyWebView(urlToLoad: "https://youtu.be/F0jJTASUhOo?si=Iob5TeWCTZCFqGC5")
                            .edgesIgnoringSafeArea(.all)
                    } label: {
                        Text("노래 들으러 가기")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink {
                        MyWebView(urlToLoad: "https://www.lipsum.com/")
                            .edgesIgnoringSafeArea(.all)
                    } label: {
                        Text("아무대나 가기")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                }
                .padding(50)
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
