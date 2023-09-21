# SwiftUI 2주차(8~12)

## ScrollView

```jsx
struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 30))
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 30))

                }
                
                Text("천원 할 일목록")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    
                
                ScrollView {
                    VStack {
                        MyProjectCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                        MyBasicCard()
                    }
                    
                }

            }.padding(10)
            
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                )
                .padding(.trailing, 10)
                .shadow(radius: 10) // 그림자 범위
            
        }
        
    }
}
```

### Button

```swift
Button {
    print("확인 버튼이 클릭되없습니다.")
} label: {
    Text("확인")
        .foregroundColor(.white)
        .padding()
        .frame(width: 80)
        .background(.blue)
        .cornerRadius(20)
}
```

### List - `\.self` 이거 모야

```swift
let items = ["Apple", "Banana", "Cherry"]

List {
    ForEach(items, id: \.self) { item in
        Text(item)
    }
}
```

- List 에서는 각각 item이 고유한 식별자를 가져야하는데 `\.self` 키워드를 통해서 해당 문자열 값 자체로 식별

### List Section

```jsx
struct MyListView: View {
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        
        List {
            Section(header: Text("오늘 할 일")) {
                ForEach(1...3, id: \.self) {
                    MyCard(icon: "book.fill", title: "책읽기 \($0)", start: "1 PM", end: "3 PM", bgColor: .green)
                }
            }
            .listRowInsets(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)) // item 간에 간격 0으로
            
            Section(header: Text("내일 할 일")) {
                ForEach(1...3, id: \.self) {
                    MyCard(icon: "book.fill", title: "책읽기 \($0)", start: "1 PM", end: "3 PM", bgColor: .blue)
                }
            }
            .listRowInsets(EdgeInsets.init(top: 10, leading: 30, bottom: 10, trailing: 10)) // item 간에 간격 0으로
        }
        .listStyle(GroupedListStyle())
        
    }
}
```

- TableView.appearance 설정을 해주는데 왜 List의 Divider가 사라질까?
    - List는 내부적으로 UIkit의 UITableView를 사용하여 콘텐츠를 표시하는데, UITableView의 appearance를 설정해주어 앱 내의 모든 TableView의 인스턴스에 영향을 준다.
- 여기서 `appearance`란? UI 컴포넌트의 전역적인 스타일 및 속성을 설정하기 위한 기능입니다.
    - ex) UIAppearance, UITabBarAppearance, UINavigationBarAppearance

![스크린샷 2023-09-19 오후 9.22.18.png](SwiftUI%202%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1(8~12)%20acfecbd58d9e40a39e46952e3ba6b034/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-09-19_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_9.22.18.png)

- 적용이 안되는데.. 그냥 modifier 사용하자

```jsx
.listRowSeparator(.hidden)
```

### NavigationView

```jsx
struct MyNaviagtionView: View {
    var body: some View {
        NavigationView {

            MyListView()
                .navigationTitle("안녕하세요!")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationBarItems(leading: Button(action: {
                    print("버튼 클릭")
                }, label: {
                    Image(systemName: "bell")
                }), trailing: NavigationLink(destination: {
                    Text("넘어온 화면입니다.")
                }, label: {
                    Image(systemName: "bookmark.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.green)
                }))
        }
        
        
    }
}
```

### GeometryReader

```jsx
struct MyGeometryReader: View {
    
    @State private var color: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .center, spacing: 0){
                
                Button {
                    withAnimation {
                        color = 0
                    }
                } label: {
                    Text("빨")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: color == 0 ? 120 : 60,height: geometry.size.height/3)
                        .background(.red)
                }
                
                Button {
                    withAnimation {
                        color = 1
                    }
                } label: {
                    Text("주")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: color == 1 ? 120 : 60,height: geometry.size.height/3)
                        .background(.orange)
                }
                
                Button {
                    withAnimation {
                        color = 2
                    }
                } label: {
                    Text("노")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: color == 2 ? 120 : 60,height: geometry.size.height/3)
                        .background(.yellow)

                }
            }
            .frame(width: geometry.size.width)
        }
        
        
    }
}
```

## Opaque type

![스크린샷 2023-09-20 오후 7.20.07.png](SwiftUI%202%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1(8~12)%20acfecbd58d9e40a39e46952e3ba6b034/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-09-20_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_7.20.07.png)

```jsx
struct Stack<Element> {
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
```

```jsx
var intStack = Stack<Int>()
```

```jsx
func makeArray() -> some Collection {
    return [1, 2, 3]
}
```

![img.png](SwiftUI%202%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1(8~12)%20acfecbd58d9e40a39e46952e3ba6b034/img.png)

```jsx
protocol TestProtocol {}
func somethings() -> some TestProtocol {} // Opaque Type
func somethings() -> TestProtocol {} // Protocol Type
```

```jsx
struct 오버워치: TestProtocol {}
struct 롤: TestProtocol {}

func somethings() -> TestProtocol {
    let 재밌다 = true
    if 재밌다 { return 롤() }
    
    return 오버워치()
}
```

```jsx
struct 오버워치: TestProtocol {}
struct 롤: TestProtocol {}

func somethings() -> ✅some✅ TestProtocol {
    let 재밌다 = true
    if 재밌다 { return 롤() }
    
    return 오버워치()
}
```

```jsx
func somethings() -> some TestProtocol {
    return 롤()
}
```

```html
protocol Shape {
    func draw() -> String
}
```

```html
struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}
```

```html
func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}
```

```html
func flip<T: Shape>(_ shape: T) -> Shape {
    return FlippedShape(shape: shape)
}
```