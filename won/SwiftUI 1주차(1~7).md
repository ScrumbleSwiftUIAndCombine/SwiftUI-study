# SwiftUI 1주차(1~7)

### @State

- 값의 변화를 감지 → 뷰에 적용

![스크린샷 2023-09-11 오후 7.53.03.png](SwiftUI%201%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1(1~7)%20159a1665126541e4bb56adbdcd245401/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-09-11_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_7.53.03.png)

- mutating 기능을 활용하여 뷰를 수정하려 해봤으나 SwiftUI 에서는 기본적으로 View는 immutable해서 mutating 키워드로 수정이 불가능

### TapGesture와 Animaiton 코드

```jsx
.onTapGesture {
          // 에니메이션과 함께
          withAnimation {
              self.isActivated.toggle()
          }
      }
```

### NavigationLink와 NavgationView

```jsx
NavigationView {
            VStack {
                HStack {
                    MyVstackView()
                    MyVstackView()
                    MyVstackView()
                }
                .padding(isActivated ? 50 : 10)
                .background(isActivated ? Color.yellow : Color.black)
                .onTapGesture {
                    // 에니메이션과 함께
                    withAnimation {
                        self.isActivated.toggle()
                    }
                } // Hstack
                NavigationLink(destination: MyVstackView()) {
                    Text("네비게이션")
                        .fontWeight(.heavy)
                        .font(.system(size: 40))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(30)
                }
            }
        } // navi
```

- NavigationLink를 활용해 화면전환 코드 구현
- NaviagtionLink는 NavgationView 내부에서만 동작하는데 그 이유는 NavigationView가 SwiftUI에서 탐색 스택을 관리하는데 사용되기 때문
- 탐색 스택: 탐색 스택은 현재 화면과 이전 화면의 상태를 추적하는 데이터 구조입니다. 탐색 관리자는 이 스택을 업데이트하고, 사용자가 뒤로 가기를 누르면 이전 화면을 팝(pop)하고, 앞으로 가기를 누르면 새로운 화면을 푸시(push)합니다.

### frame, edgesIgnoringSafeArea

```jsx
struct MyTextView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("배경 아이템 인덱스")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            Spacer()
            
        }.background(Color.blue)
            .edgesIgnoringSafeArea(.all)
    }
}
```

- frame을 활용해 Text크기 설정
- edgesIgnoringSafeArea → safeArea 무시

### @Main, APP

```jsx
@main
struct SwiftUITutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

- 프로젝트를 생성하면 AppDelegate, SeneDelegate가 없다.. 앱의 진입이나 화면 관리는 어떤식으로 하는디?
- `APP` 프로토콜은 앱의 진입점을 정의하고 앱의 구성을 설정하는데 사용합니다.
    
    ```jsx
    protocol App {
        associatedtype Body: Scene
        @SceneBuilder var body: Self.Body { get }
    }
    ```
    
    - Body는 Scene을 준수하는 associatedtype 입니다.
    - `Scene` 프로토콜은 SwiftUI에서 화면을 나타내는 추상적인 개념을 정의하는 프로토콜입니다
        - `Scene` 은 뷰 계층에서 가장 Root에 해당하며, 시스템에 의해 라이프 사이클을 가지고 있는 형태
    
    - `body` 프로퍼티를 사용해서 앱의 시작화면을 정의하고, `@main` 어트리뷰트를 사용하여 앱의 진입점으로 설정
    - `WindowGroup`  은 앱의 기본 창을 정의하고 해당 창에 표시될 **`Scene`**을 설정합니다. 주로 앱의 메인 화면을 나타내는 역할을 합니다. → 무슨 소리인지 잘모르겠으니까 그냥 Scene을 만들 때 사용하고, 터치 이벤트 같은 이벤트를 가장 먼저 수신하여 subview에 전달하는 responder chain의 역할을 수행한다.
    
    - `@SceneBuilder` 를 통해서 여러 Scene을 조합해서 하나의 Body를 생성하는 어트리뷰트
        
        ```jsx
        @main
        struct MultiSceneApp: App {
            var body: some Scene {
                WindowGroup {
                    ContentView()
                }
                
                WindowGroup("About") { // 두 번째 WindowGroup 정의
                    AboutView()
                }
            }
        }
        ```
        

### @Binding

- 변수를 다른 뷰로 전달하고 해당 변수의 값을 공유하거나 변경할 수 있도록 해주는 protperty wrapper
- 구현부

```jsx
// @Binding 키워드를 통해서 공유
    @Binding var isActivated: Bool
    
    init(isActivated: Binding<Bool> = .constant(true)) {
        _isActivated = isActivated  // '_' 접두사를 사용해서 변수의 값을 읽거나 변경 
    }
```

- ‘_’ 접두사를 붙이면 isActivated의 타입이 Bool → Binding<Bool> 로 변경

- 호출부

```jsx
MyVstackView(isActivated: $isActivated)
```

- ‘$’ 접두사를 사용해서 Bool 타입을 → Binding<Bool>타입으로 변경한다.

### @Property Wrapper - 복습해야지요

![스크린샷 2023-09-13 오전 9.25.49.png](SwiftUI%201%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1(1~7)%20159a1665126541e4bb56adbdcd245401/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-09-13_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%258C%25E1%2585%25A5%25E1%2586%25AB_9.25.49.png)

- Swift 5.1에서 추가 된 기능
- Get/Set을 사용하는 보일러플레이트 코드를 줄이기 위해서 사용

```swift
static var usesTouchID: Bool {
        get { return UserDefaults.standard.bool(forKey: "usesTouchID") }
        set { UserDefaults.standard.set(newValue, forKey: "usesTouchID") }
    }
static var myEmail: String? {
        get { return UserDefaults.standard.string(forKey: "myEmail") }
        set { UserDefaults.standard.set(newValue, forKey: "myEmail") }
    }
```

- @property wrapper를 사용하여 코드를 줄여보자

```swift

// UserDefault <- propertyWrapper 구현부
@propertyWrapper
struct UserDefault<T> {
    
    let key: String
    let defaultValue: T

    var wrappedValue: T { // wrappedValue 변수를 가져야함
        get { UserDefaults.standard.object(forKey: self.key) as? T ?? self.defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: self.key) }
    }
}

// 호출부
@UserDefault(key: "userTouch", defaultValue: Bool)
static var userTouchID: Bool
```

### SwiftUI로 Project 만들면 info.plist 어디갔어

- ATS 설정

![스크린샷 2023-09-12 오후 9.50.17.png](SwiftUI%201%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1(1~7)%20159a1665126541e4bb56adbdcd245401/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-09-12_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_9.50.17.png)

### UIViewRepresentable, UIViewControllerRepresentable

- SwiftUI 에서 UIkit 사용할 수 있게

```jsx
struct MyWebView: UIViewRepresentable {
    
    var urlToLoad: String
    
    // ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        guard let url = URL(string: urlToLoad) else {return WKWebView()}
        
        let webview = WKWebView()
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
    // 업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebView>) {
          
    }
}
```

### Text 속성 모음

```jsx
Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specim ")
                .tracking(1) // 글자간의 간격을 설정
                .font(.system(.body, design: .rounded))
                .fontWeight(.medium)
                .multilineTextAlignment(.leading) // Text 정렬
                .lineLimit(nil)
                .lineSpacing(10)
                .shadow(color: Color.red, radius: 4, x: 0, y: 10)
                .truncationMode(.head) // .. 처리
```

### Image 속성 모음

```jsx
struct CircleImageView: View {
    var body: some View {
//        Image(systemName: "bolt.circle")
//            .font(.system(size: 200))
//            .foregroundColor(.yellow)
//            .shadow(color: .gray, radius: 2, x: 10, y: 10) // radius 퍼지는 정도
        Image("sunset")
            .resizable()
            .scaledToFill()
            //.aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .shadow(color: .red, radius: 10, x: 5, y: 10)
            .overlay(Circle()
                .foregroundColor(.black)
                .opacity(0.6)
                .padding(30)
            )
            .overlay(Circle()
                .stroke(Color.red, lineWidth: 10)
                .padding(30)
            )
            .overlay(
                Circle()
                    .stroke(Color.blue, lineWidth: 10)
                    .padding(10)
            )
            .overlay(
                Text("호호")
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
            )

        
            //.clipped() // frame 크기에 맞게 자르기
        //    .edgesIgnoringSafeArea(.all)
        
    }
}
```

### 왜 .leading 정렬 안하다가 Divider() 넣어주면 정렬할까?

```jsx
struct ContentView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("신호등")
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.bold)
            
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
        }
        .frame(width: 300)
        .background(.purple)
    }
}
```

![스크린샷 2023-09-14 오후 12.42.46.png](SwiftUI%201%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1(1~7)%20159a1665126541e4bb56adbdcd245401/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-09-14_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_12.42.46.png)

- VStack에 정렬은 VStack의 width 값만큼 해주는데 지금 현재 정렬은 VStack의 크기가 100일때 해서 저렇게 정렬
- 우리는 Divider()를 추가해서 VStack width를 넓혀서 왼쪽벽에 정렬이 가능

```jsx
struct ContentView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("신호등")
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.bold)
            
            Divider()
            
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
        }
        .frame(width: 300)
        .background(.purple)
    }
}
```

![스크린샷 2023-09-14 오후 12.48.02.png](SwiftUI%201%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1(1~7)%20159a1665126541e4bb56adbdcd245401/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-09-14_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_12.48.02.png)

### ZStack

```jsx
struct MyZstack: View {
    var body: some View {
        ZStack {
            
            Rectangle()
                .frame(width: 200, height: 200)
                .foregroundColor(.red)
                .zIndex(1) // index 설정이 가능
            Rectangle()
                .frame(width: 50, height: 50)
                .foregroundColor(.green)
                .zIndex(3) // index 설정이 가능
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .zIndex(2) // index 설정이 가능
        }
    }
}
```