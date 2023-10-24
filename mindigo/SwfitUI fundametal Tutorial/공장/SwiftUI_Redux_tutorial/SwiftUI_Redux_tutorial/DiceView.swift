//
//  DiceView.swift
//  SwiftUI_Redux_tutorial
//
//  Created by min on 2023/10/04.
//

import SwiftUI

struct DiceView: View {
    
    @EnvironmentObject var store: AppStore
    
    @State private var shouldRoll = false
    @State private var pressed = false
    
    var diceRollAnimation: Animation {
        Animation.spring()
    }
    
    // 주사위 굴리기 액션 실행
    func rollTheDice() {
        print(#fileID, #function, #line)
        self.shouldRoll.toggle()
        self.store.dispatch(action: .rollTheDice)
    }
    
    var body: some View {
        VStack {
            Text(self.store.state.currentDice)
                .font(.system(size: 300, weight: .bold, design: .monospaced))
                .rotationEffect(.degrees(shouldRoll ? 360 : 0))
                .animation(diceRollAnimation, value: shouldRoll)
            Button {
                self.rollTheDice()
            } label: {
                Text("랜덤 주사위 굴리기")
                    .fontWeight(.bold)
            }
            .buttonStyle(MyButtonStyle())
            .scaleEffect(self.pressed ? 0.8 : 1.0)
            .onLongPressGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.pressed = pressed
                }
            }
        }
       
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}

