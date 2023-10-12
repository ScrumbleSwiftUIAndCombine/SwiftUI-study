//
//  MyTabView.swift
//  SwiftUI_stack_pratice_tutorial
//
//  Created by min on 2023/09/25.
//

import SwiftUI

struct MyTabView: View {
    
    var body: some View {
        TabView {
            MyPageView(title: "one", bgColor: .orange)
                .tabItem {
                    Image(systemName: "airplane")
                    Text("one")
                }
                .tag(0)
            
            MyPageView(title: "two", bgColor: .blue)
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("two")
                }
                .tag(1)
                .background(.blue)
            
            MyPageView(title: "three", bgColor: .yellow)
                .tabItem {
                    Image(systemName: "doc.fill")
                    Text("three")
                }
                .tag(2)
                .background(.yellow)
        }
    
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}

