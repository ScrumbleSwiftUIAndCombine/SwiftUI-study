//
//  MyList.swift
//  SwiftUI_stack_pratice_tutorial
//
//  Created by min on 2023/09/15.
//

import SwiftUI

struct MyList: View {
    
    var body: some View {
        List {
            Section {
                ForEach(1...2, id: \.self) {
                    MyCard(icon:  "book.fill", title: "책 읽기 \($0)", start: "10:00", end: "11:00", bgColor: Color.green)
                }
            } header: {
                Text("헤더1")
                    .font(.headline)
                    .foregroundColor(.black)
            } footer: {
                Text("footer")
            }
            .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            .listRowSeparator(.hidden)

            Section {
                ForEach(1...3, id: \.self) {
                    MyCard(icon:  "book.fill", title: "책 읽기 \($0)", start: "10:00", end: "11:00", bgColor: Color.blue)
                }
            } header: {
                Text("헤더2")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            .listRowSeparator(.hidden)
            
        }
        .listStyle(.grouped)
        .navigationTitle("내 목록")
    }
}


struct MyList_Previews: PreviewProvider {
    static var previews: some View {
        MyList()
    }
}
