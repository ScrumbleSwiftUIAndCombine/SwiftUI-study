//
//  AppStore.swift
//  SwiftUI_Redux_tutorial
//
//  Created by min on 2023/10/04.
//

import Foundation

// 앱 스토어는 앱 상태와 앱 액션을 가지고 있다.
// 앱의 상태를 지니고 있기 위해 앱 스토어를 만들어 준다.
typealias AppStore = Store<AppState, AppAction>

// ObservableOabject 앱 상태를 가지고 있는 옵저버블 오브젝트 스토어
final class Store<State, Action>: ObservableObject {
    // 외부에서 값 변경 불가
    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    
    // 제네릭 형태의 State
    // 즉 Store가 가지고 있는 제네릭 State
    // 생성자 메소드
    init(state: State, reducer: @escaping Reducer<State, Action>) {
        self.state = state
        self.reducer = reducer
    }
    
    // 디스패치를 통해 액션을 행한다.
    func dispatch(action: Action) {
        // 정의할 때는 inout, 사용할때는 &
        // 리듀서 클로저를 실행해서 액션을 필터링한다.
        reducer(&self.state, action)
    }
}
