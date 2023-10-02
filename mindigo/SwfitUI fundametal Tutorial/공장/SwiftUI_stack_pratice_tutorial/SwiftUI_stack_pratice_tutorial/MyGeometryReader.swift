//
//  MyGeometryReader.swift
//  SwiftUI_stack_pratice_tutorial
//
//  Created by min on 2023/09/25.
//

import SwiftUI

enum Index {
    case one, two, three
}

struct MyGeometryReader: View {
    
    @State var index: Index = .one
    
    let centerPosition: (GeometryProxy) -> CGPoint = { proxy in
        return .init(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
    }
    
    var body: some View {
        GeometryReader { geometryReader in
            VStack(spacing: 0) {
                
                Button {
                    withAnimation {
                        self.index = .one
                    }
                } label: {
                    Text("1")
                        .frame(width: 30, height: geometryReader.size.height / 3)
                        .padding(.horizontal, self.index == .one ? 50 : 0)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                Button {
                    withAnimation {
                        self.index = .two
                    }
                } label: {
                    Text("2")
                        .frame(width: 30, height: geometryReader.size.height / 3)
                        .padding(.horizontal, self.index == .two ? 50 : 0)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }


                Button {
                    withAnimation {
                        self.index = .three
                    }
                } label: {
                    Text("3")
                        .frame(width: 30, height: geometryReader.size.height / 3)
                        .padding(.horizontal, self.index == .three ? 50 : 0)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
//                Text("4")
//                    .frame(width: 50)
//                    .background(Color.purple)
//                    .foregroundColor(.white)
//                    .font(.largeTitle)
//                    .fontWeight(.black)
            }
            .frame(maxWidth: .infinity)
            .background(.yellow)
            .position(centerPosition(geometryReader))
//            .position(.init(x: geometryReader.frame(in: .local).midX, y: geometryReader.frame(in: .local).midY))
        }
        .background(.black)
    }
}

struct MyGeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        MyGeometryReader()
    }
}

