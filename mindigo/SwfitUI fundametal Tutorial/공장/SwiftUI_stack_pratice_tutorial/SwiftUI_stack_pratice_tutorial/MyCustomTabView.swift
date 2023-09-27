//
//  MyCustomTabView.swift
//  SwiftUI_stack_pratice_tutorial
//
//  Created by min on 2023/09/25.
//

import SwiftUI

enum TabIndex {
    case home, cart, profile
}

struct MyCustomTabView: View {
    
    @State var tabIndex: TabIndex
    @State var largerScale: CGFloat = 1.5
    
    func changeMyView(tabIndex: TabIndex) -> MyPageView {
        switch tabIndex {
        case .home:
            return MyPageView(title: "홈", bgColor: .green)
        case .cart:
            return MyPageView(title: "장바구니", bgColor: .purple)
        case .profile:
            return MyPageView(title: "프로필", bgColor: .blue)
        }
    }
    
    func chageIconColor(tabIndex: TabIndex) -> Color {
        switch tabIndex {
        case .home:
            return .green
        case .cart:
            return .purple
        case .profile:
            return .blue
        }
    }
    
    func calcCircleBgPosition(tabIndex: TabIndex, geometry: GeometryProxy) -> CGFloat {
        switch tabIndex {
        case .home:
            return -(geometry.size.width / 3)
        case .cart:
            return 0
        case .profile:
            return geometry.size.width / 3
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.changeMyView(tabIndex: self.tabIndex)
                
                Circle()
                    .frame(width: 90, height: 90)
                    .offset(x: self.calcCircleBgPosition(tabIndex: self.tabIndex, geometry: geometry), y: UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 20 : 0)
                    .foregroundColor(.white)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Button {
                            print("1")
                            withAnimation {
                                self.tabIndex = .home
                            }
                        } label: {
                            Image(systemName: "house.fill")
                                .font(.system(size: 25))
                                .foregroundColor(self.tabIndex == .home ? self.chageIconColor(tabIndex: self.tabIndex) : .gray)
                                .frame(width: geometry.size.width / 3, height: 50)
                                .scaleEffect(self.tabIndex == .home ? self.largerScale : 1.0)
                                .offset(y: self.tabIndex == .home ? -10 : 0)
                        }
                        .background(.white)
                        
                        Button {
                            print("2")
                            withAnimation {
                                self.tabIndex = .cart
                            }
                        } label: {
                            Image(systemName: "cart.fill")
                                .font(.system(size: 25))
                                .foregroundColor(self.tabIndex == .cart ? self.chageIconColor(tabIndex: self.tabIndex) : .gray)
                                .frame(width: geometry.size.width / 3, height: 50)
                                .scaleEffect(self.tabIndex == .cart ? self.largerScale : 1.0)
                                .offset(y: self.tabIndex == .cart ? -10 : 0)
                        }
                        .background(.white)
                        
                        Button {
                            print("3")
                            withAnimation {
                                self.tabIndex = .profile
                            }
                        } label: {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 25))
                                .foregroundColor(self.tabIndex == .profile ? self.chageIconColor(tabIndex: self.tabIndex) : .gray)
                                .frame(width: geometry.size.width / 3, height: 50)
                                .scaleEffect(self.tabIndex == .profile ? self.largerScale : 1.0)
                                .offset(y: self.tabIndex == .profile ? -10 : 0)
                        }
                        .background(.white)

                    }
                    
                    Rectangle()
                        .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 0 : 20)
                        .foregroundColor(.white)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MyCustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyCustomTabView(tabIndex: .home)
    }
}

