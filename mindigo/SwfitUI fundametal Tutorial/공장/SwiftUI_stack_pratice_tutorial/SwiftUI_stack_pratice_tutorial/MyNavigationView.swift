//
//  MyNavigationView.swift
//  SwiftUI_stack_pratice_tutorial
//
//  Created by min on 2023/09/25.
//

import SwiftUI

struct MyNavigationView: View {
    var body: some View {
        NavigationView {
//            Text("MyNavigationView")
            MyProfileView()
                .navigationTitle("내 프로필")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            Text("넘어온 화면")
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                        }

                    }
                }
//                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MyNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MyNavigationView()
    }
}
