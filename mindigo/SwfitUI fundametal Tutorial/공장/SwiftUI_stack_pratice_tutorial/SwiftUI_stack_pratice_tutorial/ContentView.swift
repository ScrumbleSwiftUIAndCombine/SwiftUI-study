//
//  ContentView.swift
//  SwiftUI_stack_pratice_tutorial
//
//  Created by min on 2023/09/14.
//

import SwiftUI

struct ContentView: View {
    
    @State var isNavigationBarHidden: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack {
                        NavigationLink {
                            MyList()
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                      
                        Spacer()
                        NavigationLink(destination: MyProfileView(isNavigationBarHidden: self.$isNavigationBarHidden)) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(20)
                    
                    Text("할 일 목록")
                        .font(.system(size: 40))
                        .fontWeight(.black)
                        .padding(.horizontal, 20)
                    
                    ScrollView {
                        VStack {
                            MyProjectCard()
                            MyBasicCard()
                            MyCard(icon: "tray.fill", title: "정리하기", start: "10:00", end: "10:30", bgColor: .blue)
                            MyCard(icon: "tv.fill", title: "영상 다시보기", start: "10:00", end: "10:30", bgColor: .red)
                            MyCard(icon: "cart.fill", title: "마트 장보기", start: "10:00", end: "10:30", bgColor: .orange)
                            MyCard(icon: "gamecontroller.fill", title: "게임하기", start: "10:00", end: "10:30", bgColor: .green)
                        }
                        .padding()
                    }
                }
                
                Circle()
                    .foregroundColor(.yellow)
                    .frame(width: 60, height: 60)
                    .padding()
                    .overlay {
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    .padding(10)
                    .shadow(radius: 20)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
