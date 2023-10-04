# 5주차 강의 내용 정리

### Menu를 만드는 방법
- View에 ContextMenu 붙이기
- ToolbarItem 사용하기


```Swift
struct MenuView: View {
    let myMenu = ["메뉴리스트1", "메뉴리스트2", "메뉴리스트3"]
    @State private var selected: Int = 0
    
    var body: some View {
        NavigationStack {
            Text("Hello, World!")
                .navigationTitle("Menu 연습하기")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            Section {
                                Button {
                                    print("action0")
                                
                                } label: {
                                    Label("메뉴0", systemImage: "square.and.arrow.up")
                                }
                            }
                            
                            Section {
                                Text("menu 1")
                                Text("menu 2")
                            }
                            
                            Picker(selection: $selected) {
                                ForEach(myMenu.indices, id: \.self) { index in
                                    Text(myMenu[index])
                                }
                            } label: {
                                Text("메뉴 선택!")
                            }

                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.headline)
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.black)
                                .background(.yellow)
                                .clipShape(Circle())
                        } //: Menu
                    } //: ToolbarItem
                } //: .toolbar
        } //: NavigationStack
    }
}
```
- ToolbarItem을 누르면 content 클로저에 있는 View가 나타남
- Menu의 Content는 ViewBuilder로 되어 있기 때문에 여러개의 뷰를 받아 스택으로 보여줌
- Menu 내에 버튼이 눌리면 Toolbar는 자동으로 화면에서 사라짐

### LazyVGridView
- 화면에 보여지는 부분만 렌더링


```Swift
struct MyModel: Identifiable {
    var id = UUID()
    var number: String
}

extension MyModel {
    static var dummyDatas: [MyModel] {
        (1...200).map { number in
            return MyModel(number: "\(number)번")
        }
    }
}

```
- ForEach에서 사용하기 위한 Identifiable을 채택하는 Model

```Swift
class LazyVGridViewModel: ObservableObject {
    @Published var dummyDatas: [MyModel]
    
    init() {
        dummyDatas = (1...200).map { MyModel(number: "\($0)번")}
    }
}
```
- View에서 사용하기 위한 ViewModel 생성
  
#### GridItem 종류
- columns == 하나의 행에 몇개가 들어갈 것인지 정할 수 있음.
- .fixed : 고정 크기
- .adaptive 최소 크기로 행에 여러개를 채움
- .flexible : 최소 크기로 하나를 채우고 남는 여백이 있는 경우 여백 크기 만큼 늘어남

```Swift
struct LazyVGridView: View {
    
    @ObservedObject private var viewModel = LazyVGridViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.fixed(120)), GridItem(.fixed(200))], content: {
                ForEach(viewModel.dummyDatas, id: \.id) { data in
                    Text(data.number)
                        .frame(width: 100, height: 100)
                        .background(.green)
                } //: ForEach
            })
        } //: ScrollView
    }
}
```

### LazyVGrid with Segment
```Swift
enum LayoutType: CaseIterable {
    case table, grid, triple
    
    var image: Image {
        switch self {
        case .table:
            return Image(systemName: "list.dash")
        case .grid:
            return Image(systemName: "square.grid.2x2.fill")
        case .triple:
            return Image(systemName: "square.grid.3x3.fill")
        }
    }
    
    var gridItems: [GridItem] {
        switch self {
        case .table:
            return [GridItem(.flexible())]
        case .grid:
            return [GridItem(.flexible()), GridItem(.flexible())]
        case .triple:
            return [GridItem(.adaptive(minimum: 100))]
        }
    }
}
```
- 각 세그먼트의 이미지와 gridItems를 enum 내부에 지정

```Swift
struct SegmentLayoutView: View {
    @State private var selectedLayoutType: LayoutType = .table
    @ObservedObject private var viewModel = LazyVGridViewModel()
    
    var body: some View {
        VStack {
            Picker(selection: $selectedLayoutType) {
                ForEach(LayoutType.allCases, id: \.self) {
                    type in
                    type.image
                }
            } label: {
                Text("이것이 제목")
            } //: Picker
            .pickerStyle(.segmented)
            ScrollView {
                LazyVGrid(columns: selectedLayoutType.gridItems, content: {
                    ForEach(viewModel.dummyDatas, id: \.id) { data in
                        Text(data.number)
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .background(.green)
                    } //: ForEach
                })
                .animation(.easeInOut, value: selectedLayoutType)
            } //: ScrollView
        } //: VStack
    }
}
```

```Swift
                    switch selectedLayoutType {
                    case .table:
                        ForEach(viewModel.tableDatas, id: \.id) { data in
                            Text(data.number)
                                .frame(maxWidth: .infinity)
                                .frame(height: 100)
                                .background(.green)
                        } //: ForEach
                    case .grid:
                        ForEach(viewModel.gridDatas, id: \.id) { data in
                            Text(data.number)
                                .frame(maxWidth: .infinity)
                                .frame(height: 100)
                                .background(.green)
                        } //: ForEach
                    case .triple:
                        ForEach(viewModel.tripleDatas, id: \.id) { data in
                            Text(data.number)
                                .frame(maxWidth: .infinity)
                                .frame(height: 100)
                                .background(.green)
                        } //: ForEach
                    }
```
- LazyVGrid 내부에서 각 세그먼트 타입별로 다른 아이디를 가지는 View 목록을 반환하는 경우 animation이 적용되지 않는 것을 볼 수 있음. 애니메이션은 같은 id를 가진 View 사이의 transition에서만 적용됨

### Redux Architecture
- store: 앱 전체의 상태를 가지고 있음. view에 바인딩이 되어 있어, 스토어가 변경되면 View의 UI가 업데이트 됨
- action: 리듀서에게 상태 변경을 알림
- reducer: 현재 앱 상태를 받거나 앱 상태를 변경하기 위해 액션을 보냄

##### AppState
- 앱의 UI를 그려주기 위한 데이터나 상태를 가지고 있음
- 이를 Published로 선언해 View에서 옵저빙하여 UI를 업데이트 하도록 함
```Swift
struct AppState {
    var currentEmoji: String = ""
}
```

##### AppAction
- 앱의 상태를 변경하기 위한 액션을 정의
```Swift
enum AppAction: String {
    case changeTheEmoji
}
```
- 앱에서 발생할 수 있는 액션 목록 

##### Reducer
- AppState와 AppAction을 매개변수로 받는 클로저 형태
- Action에 알맞은 변화를 State에 적용함

```Swift
typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(_ state: inout AppState, _ action: AppAction) {
    // 들어오는 액션에 따라 분기 처리 - 즉 필터링
    switch action {
    case .changeTheEmoji:
        // 앱의 상태를 변경
        state.currentEmoji = ["⏰", "⭐️", "👉", "🔗", "🙃"].randomElement() ?? "💳"
    }
}

```

##### AppStore
```Swift
typealias AppStore = Store<AppState, AppAction>

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    
    // reducer 클로져
    private let reducer: Reducer<State, Action>
    
    init(state: State, reducer: @escaping Reducer<State, Action>) {
        self.state = state
        self.reducer = reducer
    }
    
    func dispatch(action: Action) {
        reducer(&self.state, action)
    }
}

```
- 초기값으로 AppState와 Reducer 클로저를 전달 받음. 
- Store 객체의 dispatch(action:)을 실행하면 AppAction에 알맞는 값의 변화가 AppState에 일어나게 됨
- state의 변화는 @Published 정의에 의해 View에 즉시 반영됨

##### View
```Swift
struct DiceView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack {
            Text(self.store.state.currentEmoji)
                .font(.system(size: 300, weight: .bold, design: .monospaced))
            
            Button {
                self.changeEmoji()
            } label: {
                Text("랜덤 이모지")
            } //: Button
            .buttonStyle(.borderedProminent)
        } //: VStack
    }
    
    // MARK: - Fuction
    func changeEmoji() {
        self.store.dispatch(action: .changeTheEmoji)
    }
}

```
- Button을 누르면 옵저빙 하고 있던 environmentObject인 AppStore의 dispatch 함수가 실행 됨