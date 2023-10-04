//
//  ContentView.swift
//  SwiftUI_Redux_tutorial
//
//  Created by min on 2023/10/04.
//

import SwiftUI

struct ContentView: View {
    
    let store = AppStore(state: AppState.init(currentDice: "⚀"), reducer: appReducer(_:_:))
    
    var body: some View {
       DiceView()
            .environmentObject(store)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
