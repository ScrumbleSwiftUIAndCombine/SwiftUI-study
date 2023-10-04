//
//  Reducer.swift
//  SwiftUI_Redux_tutorial
//
//  Created by min on 2023/10/04.
//

import Foundation

// 매개변수로 들어오는 값을 변경하기 위해 inout 키워드를 붙여준다.
// 별칭을 짓는 것 오른쪽에 있는 식을 왼쪽의 식으로 이름을 변경한다.
// (inout State, Action) -> Void 해당 클로저 자체를 별칭으로 리듀서로 칭한다.
typealias Reducer<State, Action> = (inout State, Action) -> Void

// 필터링을 하는 메소드
func appReducer(_ state: inout AppState, _ action: AppAction) -> Void {
    // 들어오는 액션에 따라 분기 처리
    switch action {
    case .rollTheDice:
        // 앱의 상태를 변경
        state.currentDice = ["⚀", "⚁", "⚂", "⚃", "⚄", "⚅"].randomElement() ?? "⚀"
    }
}
