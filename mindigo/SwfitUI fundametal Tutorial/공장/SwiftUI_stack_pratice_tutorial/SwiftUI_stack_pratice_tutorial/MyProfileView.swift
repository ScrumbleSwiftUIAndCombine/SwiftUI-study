//
//  MyProfileView.swift
//  SwiftUI_stack_pratice_tutorial
//
//  Created by min on 2023/09/25.
//

import SwiftUI

struct MyProfileView: View {
    
    @Binding var isNavigationBarHidden: Bool
    
    init(isNavigationBarHidden: Binding<Bool> = .constant(false)) {
        _isNavigationBarHidden = isNavigationBarHidden
    }
    
    var body: some View {
        VStack {
            Image("image3")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 250, height: 250)
                .shadow(color: .gray, radius: 10, x: 10, y: 10)
                .overlay {
//                    Circle().stroke(.yellow, lineWidth: 15)
                    Circle().strokeBorder(.yellow, lineWidth: 15)
                }
                .padding(.top, 30)
            
            
            Text("안녕하세요")
                .font(.system(size: 30, weight: .bold))
                .padding(.top, 30)
            
            Text("안뇽")
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 5)
            
            HStack {
                Button("구독하러 가기") {
                    print("구독하러 가기")
                }
                .padding(15)
                .background(.red)
                .cornerRadius(15)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold))
                
                Button("오픈채팅방 가기") {
                    print("오픈채팅방 가기")
                }
                .padding(15)
                .background(.orange)
                .cornerRadius(15)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold))
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .navigationTitle("내 프로필")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: Text("aa")) {
                    Image(systemName: "gear")
                }
            }
        }
        .onAppear {
            self.isNavigationBarHidden = false
        }
    }
}


struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
