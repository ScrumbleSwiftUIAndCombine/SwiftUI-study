//
//  MyPageView.swift
//  SwiftUI_stack_pratice_tutorial
//
//  Created by min on 2023/09/25.
//

import SwiftUI

struct MyPageView: View {
    
    var title: String
    var bgColor: Color
    
    var body: some View {
        ZStack {
            bgColor
            
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.black)
        }
        .animation(nil, value: UUID())
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(title: "프리뷰", bgColor: .orange)
    }
}

