# SwiftUI 3주차(13~20)

### GeometryProxy 위치 잡는 클로저

```jsx
let centerPostion: (GeometryProxy) -> CGPoint = { proxy in
        return CGPoint(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
    }

GeometryReader { proxy in
    .position(centerPostion(proxy)) 
}

```

### Stack에 Color 넣으면

```jsx
var body: some View {
      ZStack {
          Color.orange
      }
  }
```

<img width="174" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-25_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_12 22 48" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/010a17e5-884a-4c31-aecd-b1bcff37caa9">

### Tabbar Code

```jsx
struct MyTabView: View {
    var body: some View {
        TabView {

            MyView(text: "테스트1", color: .yellow)
                .tabItem {
                    Image(systemName: "airplane")
                }
                .tag(0)
            MyView(text: "테스트2", color: .blue)
                .tabItem {
                    Image(systemName: "flame.fill")
                }
                .tag(1)
            MyView(text: "테스트3", color: .green)
                .tabItem {
                    Image(systemName: "doc.fill")
                }
                .tag(2)
        }
    }
}
```

### TabBar Appearance 사용해서 색상 변경

```jsx
.onAppear() {
    UITabBar.appearance().backgroundColor = .white
}
```

### Animation View에 적용 안하기

```jsx
.animation(.none)
```

### Custom TabBar

```jsx
enum TabIndex {
    case home
    case cart
    case profile
}

struct MyCustomTabView: View {
    
    @State var tabIndex: TabIndex
    
    @State var lagerScale: CGFloat = 1.3
    
    let centerPostion: (GeometryProxy) -> CGPoint = { proxy in
        return CGPoint(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
    }
    
    func chageMyView() -> MyView {
        switch tabIndex {
        case .home:
            return MyView(text: "홈", color: .blue)
        case .cart:
            return MyView(text: "장바구니", color: .purple)
        case .profile:
            return MyView(text: "프로필", color: .green)
        }
    }
    
    func changeIconColor() -> Color {
        switch tabIndex {
        case .home:
            return .blue
        case .cart:
            return .purple
        case .profile:
            return .green
        }

    }
    
    func calcCirCleBgPosition(proxy: GeometryProxy) -> CGFloat {
        switch tabIndex {
        case .home:
            return -(proxy.size.width / 3)
        case .cart:
            return 0
        case .profile:
            return (proxy.size.width / 3)
        }
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                chageMyView()
                
                Circle()
                    .frame(width: 90, height: 90)
                    .offset(x: self.calcCirCleBgPosition(proxy: proxy),y: 0)
                    .foregroundColor(.white)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Button {
                            withAnimation {
                                self.tabIndex = .home
                            }
                            
                        } label: {
                            Image(systemName: "house.fill")
                                .font(.system(size: 25))
                                .scaleEffect(self.tabIndex == .home ? self.lagerScale : 1.0)
                                .foregroundColor(self.tabIndex == .home ? self.changeIconColor() : Color.gray)
                                .frame(width: proxy.size.width / 3, height: 50)
                                .offset(y: self.tabIndex == .home ? -10 : 0)
                                
                        }
                        
                        Button {
                            withAnimation {
                                self.tabIndex = .cart
                            }
                            
                        } label: {
                            Image(systemName: "cart.fill")
                                .font(.system(size: 25))
                                .scaleEffect(self.tabIndex == .cart ? self.lagerScale : 1.0)
                                .foregroundColor(self.tabIndex == .cart ? self.changeIconColor() : Color.gray)
                                .frame(width: proxy.size.width / 3, height: 50)
                                .offset(y: self.tabIndex == .cart ? -10 : 0)
                                
                        }
                        
                        Button {
                            withAnimation {
                                self.tabIndex = .profile
                            }
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 25))
                                .scaleEffect(self.tabIndex == .profile ? self.lagerScale : 1.0)
                                .foregroundColor(self.tabIndex == .profile ? self.changeIconColor() : Color.gray)
                                .frame(width: proxy.size.width / 3, height: 50)
                                .offset(y: self.tabIndex == .profile ? -10 : 0)
                                
                        }
                    }
                    .background(.white)
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 0 : 20)
                }
                

            }
            .edgesIgnoringSafeArea(.all)
            .position(centerPostion(proxy))
        }
    }
}
```

### Camera, ATS 권한 설정

<img width="593" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-27_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_1 00 52" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/aec83c66-aca4-46ab-aa1c-e29185d42ad1">

### SheetView

```jsx
.sheet(isPresented: $isPresentingScanner) {
            View()
  }
```

## SwiftUI View LifeCycle

```swift
.onAppear() { 
    print("contentView appear")
    
}

.onDisappear() {
    print("contentView disappear")
}
```

- 최상단의 뷰에 적용

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
        }
        .onAppear() {
            print("VStack appear")
            
        }
        .onDisappear() {
            print("Vstack disappear")
        }
    }
}
```

- 모든 뷰에 적용 가능

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .onAppear() {
                    print("imageView appear")
                    
                }
                .onDisappear() {
                    print("imageView disappear")
                }
        }
        .padding()
        .onAppear() {
            print("VStack appear")
            
        }
        .onDisappear() {
            print("Vstack disappear")
        }
    }
}

// 출력
// VStack appear
// imageView appear
```

- 상단에 View가 pop되어도 appear는 호출이 안돼
- 구현하려면 상단의 View가 disappear 되는 시점에 @bind 사용해서 구현

### LifeCycle과 비슷한 Modifer

```swift
.onChange(of: count) { newValue in
    print("\(newValue)")
}  

.task {
      self.viewModel.requestNames() 
}
```

- `onChange` count 값이 변경되면 호출되는 Modifer

```swift
struct ContentView: View {
    
   @State var count = 0
    
    var body: some View {
        VStack {
            Button("\(self.count)") {
                count += 1
            }
            
        }

        .onChange(of: count) { newValue in
            print("Count changed: \(newValue)")
        }
    }
}
```

### Task

- 기존에 네트워크 요청 시점은 `.onAppear`  → iOS 15 에서 `Task` Modifer 등장
- 정의: view가 나타날 때 수행할 비동기 작업을 추가합니다. → 네트워크 요청을 위해

```swift
var body: some View {
    List {
        ForEach(self.viewModel.names, id: \.self) { name in
            Text(name)
        }
    }.task {
        self.viewModel.requestNames() 
    }
    }
```

- `Task` 의 장점 View랑 동일한 생명 주기를 가짐 → 비동기처리 작업이 진행 중 이여도 View가 종료되면 같이 종료됨

### Button Style

```jsx
enum ButtonType {
    case tab
    case long
}

struct MyButtonStyle: ButtonStyle {
    
    var color: Color
    var type: ButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .background(color)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
            .onTapGesture {
                if self.type == .tab {
                    let haptic = UIImpactFeedbackGenerator(style: .light)
                    haptic.impactOccurred() //
                }
            }
            .onLongPressGesture {
                if self.type == .long {
                    let haptic = UIImpactFeedbackGenerator(style: .heavy)
                    haptic.impactOccurred() //
                }

            }
    }
}
```

## **DynamicProperty**

- State 정의 부분

<img width="634" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_1 29 22" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/1c4fc5c4-f25f-4d3d-bc34-d40684a4ead8">
- DynamicProperty 내부적으로 update() 메서드를 가짐 → 값이 변경되는 시점에 뷰를 업데이트

<img width="660" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_1 33 14" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/9a8d7385-1954-416b-8827-abe02de58c91">
### Custom으로 State 만들기


<img width="588" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2 07 10" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/36299868-679b-40f7-8564-9c851ed0b282">

<img width="560" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2 15 46" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/6631487b-2493-432c-9b37-217bd2bc7f60">

- count는  값이 변하면 안된다 왜? 구조체에 프로퍼티이니까 근데 왜 변경하려 하냐?

<img width="685" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2 22 12" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/0611a477-fd27-46e1-9770-57713a93fed8">

- nonmutating 키워드로 아니다 set 함수에 내부에서는 value 값을 변경하지 않는다 알려줌!

<img width="354" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2 26 22" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/78b66a90-6f4b-40da-9a99-fc20b8e39fcc">

- 그렇구나 1값을 넣어도 내부에서 변경되는 값은 없구나 인지 하고 허락해줌

<img width="776" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2 28 04" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/33aa1898-e3fd-44d2-9259-dc0ee5ba21bc">


- 선언 부에서 왜 nomutating 이라 해놓고 value 값 변경하냐!!!!!

<img width="548" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2 30 13" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/6d4edde7-64aa-468d-a1b7-c3044a4c9f6d">

- @State 활용해서 수정하면 정상적으로 동작하는 CustomState 완성!

### TextField

```jsx
struct ContentView: View {
    
    @State private var inputValue: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("사용자 이름", text: $inputValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                Button {
                    self.inputValue = ""
                } label: {
                    if self.inputValue.count > 0 {
                        Image(systemName: "multiply.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.secondary)
                    }
                }
            }
            HStack {
                SecureField("비밀번호를 입력해주세요!", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    self.inputValue = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.secondary)
                }
            }
            
            Text("입력한 비밀번호: \(password)")
        }
        .padding(.horizontal, 50)
    }
}
```

### **[PopupView](https://github.com/exyte/PopupView) 라이브러리**

```jsx
struct ContentView: View {
    
    @State var showingPopup = false
    
    @State var catPopUp = false
    
    func makeCatPopUp() -> some View {
        HStack(alignment: .center, spacing: 20) {
            Image("cat")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text("안내 메세지")
                    .fontWeight(.black)
                    .foregroundColor(.white)
                Text("토스트메세지입니다")
                    .lineLimit(2)
                    .font(.system(size: 14))
                    .foregroundColor(Color.white)
                Divider().opacity(0)
            }
        }
        .padding(15)
        .frame(width: 300)
        .background(.green)
        .cornerRadius(20)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    self.showingPopup = true
                } label: {
                    Text("토스트띄우기")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(.blue)
                        .cornerRadius(15)
                }
                
                Button {
                    self.catPopUp = true
                } label: {
                    Text("고양이")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(.green)
                        .cornerRadius(15)
                }
                

            }
        }
        .popup(isPresented: $showingPopup) {
            Text("The popup")
                .frame(width: 200, height: 60)
                .background(.secondary)
        } customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .autohideIn(1)
        }
        
        .popup(isPresented: $catPopUp) {
            makeCatPopUp()
        }customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .autohideIn(1)
        }

    }
}
```

### HexCode 변환

```jsx
extension Color {
    init(hexCode: String) {
        let scanner = Scanner(string: hexCode)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0x00ff00) >> 8
        let blue = rgbValue & 0x0000ff
        
        self.init(red: Double(red) / 0xff, green: Double(green) / 0xff, blue: Double(blue) / 0xff)
        
    }
}
```

### PickerView Code

```jsx
struct ContentView: View {
    
    var dic: [Int: Color] = [ 0: .red, 1: .green, 2: .blue]
    
    @State private var selectionValue = 0
    
    var body: some View {
        VStack {
            
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(dic[selectionValue])
            
            Picker("피커", selection: $selectionValue) {
                Text("빨강").tag(0)
                Text("초록").tag(1)
                Text("파랑").tag(2)
            }
            .pickerStyle(.inline)
            .overlay  {
                RoundedRectangle(cornerRadius: 10)
                    .stroke( dic[selectionValue]!, lineWidth: 2)
            }
            
            Picker("피커", selection: $selectionValue) {
                Text("빨강").tag(0)
                Text("초록").tag(1)
                Text("파랑").tag(2)
            }
            .pickerStyle(.segmented)
            
            
            
        }
        .padding()
    }
}
```

### ForEach Filter

```jsx
struct MyFilteredList: View {
    
    @State private var filteredValue = School.elementary
    @State private var myFriendsList = [MyFriend]()
    
    init() {
        var newList = [MyFriend]()
        
        for i in 0...20 {
            newList.append(MyFriend(name: "친구 \(i)", school: School.allCases.randomElement()!))
        }

        _myFriendsList = State(initialValue: newList) // State 속성 초기화
            )
        //myFriendsList = newList
    }
    
    var body: some View {
        VStack {
            Text("선택된 필터: \(filteredValue.rawValue)")
            Picker("피커", selection: $filteredValue) {
                Text("초등학교").tag(School.elementary)
                Text("중학교").tag(School.middle)
                Text("고등학교").tag(School.high)
            }
            .pickerStyle(.segmented)
            
            List {
                
                ForEach(myFriendsList.filter({ $0.school == filteredValue })) { item in
                    HStack {
                        Text("name: \(item.name)")
                        Text("School: \(item.school.rawValue)")
                    }
                }
                
//                ForEach(myFriendsList, id: \.self) { item in
//                    HStack {
//                        Text("name: \(item.name)")
//                        Text("School: \(item.school.rawValue)")
//                    }
//
//                }
            }
            
        }
//        .onAppear() {
//            var newList = [MyFriend]()
//
//            for i in 0...20 {
//                newList.append(MyFriend(name: "친구 \(i)", school: School.allCases.randomElement()!))
//            }
//
//           // _myFriendsList = State(initialValue: newList)
//            myFriendsList = newList
//        }

    }
```

- @State는 뷰의 초기화 시점에만 사용하지 init 에서는 사용이 불가능하다

### DeepLink

```jsx
struct ContentView: View {
    
    @State var selectedTab = TabIdentifier.todo
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab, content: {
                ListView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }.tag(TabIdentifier.todo)
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle")
                    }.tag(TabIdentifier.profile)
            })
            .onOpenURL { url in
                guard let tabId = url.tabIdentifier else { return }
                selectedTab = tabId
                            
            }
               
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// 어떤 탭
enum TabIdentifier: Hashable {
    case todo
    case profile
}

// 어떤 페이지
enum PageIdentifier: Hashable {
    case todoItem(id: UUID)
}

extension URL {
    
    var isDepplink: Bool {
        return scheme == "deeplink-swiftui"
    }
    
    var tabIdentifier: TabIdentifier? {
        guard isDepplink else { return nil }
        
        switch host {
        case "todo":
            return .todo
        case "profile":
            return .profile
        default:
            return nil
        }
    }
    
    var detailPage: PageIdentifier? {
        guard let tabId = tabIdentifier, pathComponents.count > 1, let uuid = UUID(uuidString: pathComponents[1]) else { return nil }
        
        switch tabId {
        case .todo:
            return .todoItem(id: uuid)
        case .profile:
            return .todoItem(id: uuid)
        }
    }
    
}
```
