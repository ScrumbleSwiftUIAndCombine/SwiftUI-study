# SwiftUI 5주차(23~31)

### AnyCancellable

```swift
var subscription = Set<AnyCancellable>()
```

- RxSwift에 disposeBag 같은 느낌
- 메모리에서 날려주는 역할

### Combine으로 데이터 스트림 생성

```swift
func fetchRandomUsers() {
      AF.request(RandomUserAPi.requestAll.url)
          .publishDecodable(type: RandomUser.self)
          .compactMap {  // opitonal Value unwrap
              $0.value
          }
          .sink { completion in
              print("데이터스트림 완료")
          } receiveValue: { receivedValue in
              print(receivedValue)
              receivedValue.results.forEach { item in
                  self.randomUserList.append(randomUserUseData(name: item.name.first + " " + item.name.last, imageURL: item.picture.large))
              }
              
          }.store(in: &subscription)

  }
```

- Alamofire에 내장된 publisher를 사용해서 스트림 생성
- 간단한 Combine 정리
    - Publisher 정의: Publisher는 하나 이상의 Subscriber인스턴스에게 element를 제공합니다.  → Rx의 Observable 같은 느낌
    - Subscriber 구독해서 Publisher의 변화를 감지 하는 역할 sink를 사용해서 호출

```swift
let publisher = Just("Zedd")  // Just는 Publisher를 채택한 구조체
        
let subscriber = publisher.sink { (value) in
      print(value) // "Zedd"
}
```

### URLImage 라이브러리

- SwiftUI에서 imageView로 이미지 리턴

```swift
URLImage(url: url) { image in
    image
        .resizable()
        .aspectRatio(contentMode: .fit)
}
```

- https://github.com/dmytro-anokhin/url-image

### SwiftUI-IntroSpect

- SwiftUI에서 UIkit의 기본 요소들을 가져와 사용할 수 있는 라이브러리
- 내부적으로 UIRepresentable로 구성되어 있다.

```swift
List {
    Text("Item")
}
.introspect(.list, on: .iOS(.v13, .v14, .v15)) { tableView in
    tableView.backgroundView = UIView()
    tableView.backgroundColor = .cyan
}
.introspect(.list, on: .iOS(.v16, .v17)) { collectionView in
    collectionView.backgroundView = UIView()
    collectionView.subviews.dropFirst(1).first?.backgroundColor = .cyan
}
```

- https://github.com/siteline/swiftui-introspect

### Combine Subject

![5주차1](https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/58ed4224-f116-45b9-9e4c-1a5ddeb81961)

- 앞서 나온 Just와 동일하게 Publisher 프로토콜을 채택한 구조체
- Subject는 Stream에 send 메서드를 호출해서 값을 주입할 수 있는 Publisher
- Rx의 Subject와 유사한 형태

```swift
var refreshActionSubject = PassthroughSubject<Void, Never>() // Subject 생성

viewModel.refreshActionSubject.send() // 이벤트 방출
```

### Combine: Subject 종류

![5주차2](https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/51d4f54e-d642-4c5f-9bd0-48ed93de05b1)
![5주차3](https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/afd89810-3dc3-45a0-add8-7d8e391d1e59)


- CurrentValueSubject는 값을 버퍼에 저장하여 관리한다
    - 초기값의 유무 CurrentValueSubject는 초기값이 필요하다
    
    ```swift
    let passSubject = PassthroughSubject<Int, Never>()
    let currentSubject = CurrentValueSubject<Int, Never>(0)
    
    passSubject.value // 호출 불가 
    currentSubject.value // 0 출력
    
    currentSubject.sink { value in
        print(value)
    }.store($apahflwj)
    
    currentSubject.sent(1)
    currentSubject.sent(2)
    currentSubject.sent(3)
    ```
    

### Router 코드

```swift
import Foundation
import Alamofire

let BASE_URL = "https://randomuser.me/api/"

enum RandomUserRouter: URLRequestConvertible {
    case getUsers(page: Int = 1, results: Int = 20)
    
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
        case .getUsers:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .getUsers(page, results):
            var params = Parameters()
            params["page"] = page
            params["results"] = results
            params["seed"] = "dev_yoon"
            
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
        case .getUsers:
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        
        return request
    }
    
}
```

### Equatable

```swift
extension randomUserUseData: Equatable { 
    static func == (lhs: randomUserUseData, rhs: randomUserUseData) -> Bool {
        return lhs.id == rhs.id
    }
}
```

- randomUserUseData 내부의 id값을 활용해서 비교 연산자 구현

### TroubleShooting

- 공통적인 버튼 스타일 생성

```swift
import Foundation
import SwiftUI

struct CommonButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .font(.system(size: 20))
            .fontWeight(.bold)
            .background(Color("mainColor"))
            .foregroundColor(.black)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .padding(.horizontal, 20)
    }
}

struct DisableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .font(.system(size: 20))
            .fontWeight(.bold)
            .background(.white)
            .foregroundColor(.gray)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.horizontal, 20)
    }
}
```

- 삼항 연산자로 버튼 스타일 설정

```swift
struct ContentView: View {
    
    @State var buttonEnable: Bool = true
    
    var body: some View {
        VStack {
        
            Button(action: {
                buttonEnable.toggle()
            }, label: {
                Text("기본 버튼")
            })
            .buttonStyle(buttonEnable ? CommonButtonStyle() : DisableButtonStyle())
                // 오류 발생
        }
        
    }
}
```

<img width="689" alt="5주차4" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/2822d849-9adc-4f19-bcd6-e86e8855dbdf">


- 타입이 달라 오류 발생

```swift
struct ContentView: View {
    
    @State var buttonStyleType: ButtonStyle = CommonButtonStyle() // 오류 발생
    
    var body: some View {
        VStack {
        
            Button(action: {
            
            }, label: {
                Text("기본 버튼")
            })
            .buttonStyle(buttonStyleType)
                
        }
        
    }
}
```
<img width="536" alt="5주차5" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/392cc608-fcc7-44dc-b1ce-7a1672aab5c3">


```swift
struct ContentView: View {
    
    @State var buttonStyleType: any ButtonStyle = CommonButtonStyle() // 오류 발생
    
    var body: some View {
        VStack {
        
            Button(action: {
            
            }, label: {
                Text("기본 버튼")
            })
            .buttonStyle(buttonStyleType) // 오류 발생
                
        }
        
    }
}
```
<img width="316" alt="5주차6" src="https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/5990756a-2c32-47cb-a85b-80b08c71a8d5">


- ButtonStyle은 타입으로 사용이 힘들 것 같아서 wrapping을 해보자

```swift
struct AnyButtonStyle: ButtonStyle {
    
    private let makeBodyConfig: (ButtonStyle.Configuration) -> AnyView // AnyView View를 wrapping 해서 리턴 타입을 맞춰주는 타입
    
    init<T: ButtonStyle>(_ style: T) {
        makeBodyConfig = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        makeBodyConfig(configuration)
    }
}
```

```swift
struct ContentView: View {
    
    @State var buttonEnable: Bool = true
    
    var body: some View {
        VStack {
        
            Button(action: {
                buttonEnable.toggle()
            }, label: {
                Text("기본 버튼")
            })
            .buttonStyle(buttonEnable ? AnyButtonStyle(CommonButtonStyle()) : AnyButtonStyle(DisableButtonStyle()))
                
        }
        
    }
}
```

https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/7e4a65d9-6c52-49be-94b2-ea0a1917c804


- 매번 AnyButtonStyle로 래핑하는거 불편하니까

```swift
extension ButtonStyle {
        var any: AnyButtonStyle {
        AnyButtonStyle(self)
    }
}
```

```swift
struct ContentView: View {
  
  @State var buttonEnable: Bool = true
  
  var body: some View {
      VStack {
          Button(action: {
              buttonEnable.toggle()
          }, label: {
              Text("기본 버튼")
          })
          .buttonStyle(buttonEnable ? CommonButtonStyle().any : DisableButtonStyle().any)            
      }
  }
}
```

### ViewModifier

```swift
struct ContentView: View {
    var body: some View {
        
        VStack(spacing: 30) {
            Text("Hello, World")
                .modifier(MyRoundedText())
            Text("Hello, World")
                .myRoundedTextStyle()
            Image(systemName: "person")
                .myRoundedTextStyle()
        }
        
        
    }
}

struct MyRoundedText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .background(Color.yellow)
            .cornerRadius(10)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 10)
                    .foregroundColor(.blue)
            )
    }
    
}

extension View {
    func myRoundedTextStyle() -> some View {
        self.modifier(MyRoundedText())
    }
}
```

### @Environment

- 환경 변수를 읽고 갱신하는데 사용하는 Property Wrapper

### 다크모드 정보 받아오기

```swift
@Environment(\.colorScheme) var scheme 
```

### 받아온 다크 모드정보로 Color return

```swift
struct Theme {
    static func myBackgroundColor(forScheme scheme: ColorScheme) -> Color {
        let lightColor = Color.white
        let darkColor = Color.black
        
        switch scheme {
        case .dark:
            return darkColor
        case .light:
            return lightColor
        @unknown default:
            return lightColor
        }
    }
}
```

### 화면 캡쳐& 녹화 방지 코드

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            MainView()
            BlockView()
        }
    }
}

struct AlertData: Identifiable {
    var id = UUID()
    var title: String
    var message: String

    init(title: String = "안녕하세요", message: String = "스크린샷 찍지마 임마") {
        self.title = title
        self.message = message
    }
}

struct BlockView: View {
    
    @State var isRecording = false
    @State var alertData: AlertData?
    
    
    var body: some View {
        ZStack {
            if isRecording {
                Color.white
                Text("화면 녹화중임니다")
                    .font(.largeTitle)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIScreen.capturedDidChangeNotification)) { _ in
            isRecording = UIScreen.main.isCaptured // 녹화 확인
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
            alertData = AlertData()
        }
        .alert(item: $alertData) { alertData in
            Alert(title: Text(alertData.title), message: Text(alertData.message))
        }
    }
}
```

### 마음대로 정리하는 Property Wrapper

- @State - 값의 변화를 감지하고 변화 시 뷰를 수정
- @Binding - 다른뷰의 state로 선언된 값을 가져와서 사용할 때 사용, 서로 공유가 가능하다.
- @ObservedObject - 내부의 Published 변수가 변하면 뷰를 수정
- @EnvironmentObject - Published 수정시에 .onReceive를 통해서 변경된 값을 받을 수 있다. → Combine
    
    ```swift
    ContentView()
       .environmentObject(EnviormentClass()) // 주입
    
    struct ContentView: View { // 선언
        @EnvironmentObject var enviorment: EnviormentClass
    }
    
    Text("")
        .onReceive(enviorment.$text) { text in // 이벤트 방출 감지
                print("text")
       }
    ```
    
    ### Menu 생성
    
    ```swift
    var siteMenu: some View {
          Menu {
              Button {
                  print("정대리 웹뷰 이동")
              } label: {
                  Text("정대리 웹뷰 이동")
              }
              Button {
                  print("네이버로 이동")
              } label: {
                  Text("네이버로 이동")
              }
              Button {
                  print("구글 이동")
              } label: {
                  Text("구글 이동")
              }
          } label: {
              Text("사이트로 이동")
          }
      }
    ```
    
    ### SwiftUI Coordinator
    
    - UIkit의 Delegate 등을 사용하고 싶을 때 사용하는
    
    ```swift
    struct MyTextAlertView: UIViewControllerRepresentable {
        
        @Binding var textString: String
        @Binding var showAlert: Bool
        
        var title: String
        var message: String
        
        
        //처음
        func makeUIViewController(context: UIViewControllerRepresentableContext<MyTextAlertView>) -> some UIViewController {
            return UIViewController()
        }
        
        //값이 변경 시
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<MyTextAlertView>) {
            
    //        guard context.coordinator.uiAlertController == nil else { return }
            
            if self.showAlert {
                let uiAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                uiAlertController.addTextField(configurationHandler: { textField in
                    textField.placeholder = "전달할 값을 입력하세요"
                    textField.text = textString
                })
                
                uiAlertController.addAction(UIAlertAction(title: "취소", style: .destructive) { _ in
                    print("취소가 클릭되었다")
                    self.textString = ""
                })
                
                uiAlertController.addAction(UIAlertAction(title: "보내기", style: .default) { _ in
                    if let textField = uiAlertController.textFields?.first, let inputText = textField.text {
                        self.textString = inputText
                    }
                    
                    uiAlertController.dismiss(animated: true) {
                        print("보내기 버튼 클릭")
                        self.showAlert = false
                    }
                })
                
                DispatchQueue.main.async {
                    uiViewController.present(uiAlertController, animated: true) {
                        self.showAlert = false
                        context.coordinator.uiAlertController = nil
                    }
                }
            }
            
      
            
        }
        
        func makeCoordinator() -> MyTextAlertView.Coordinator {
            MyTextAlertView.Coordinator(self)
        }
        
        
        // 중간에 매개
        class Coordinator: NSObject {
            var uiAlertController: UIAlertController?
            
            var myTextAlertView: MyTextAlertView
            
            init(_ myTextAlertView: MyTextAlertView) {
                self.myTextAlertView = myTextAlertView
            }
        }
    }
    
    extension MyTextAlertView.Coordinator: UITextFieldDelegate {
        // 글자가 입력이 될때
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            if let text = textField.text as NSString? {
                self.myTextAlertView.textString = text.replacingCharacters(in: range, with: string)
            } else {
                self.myTextAlertView.textString = ""
            }
            return true
        }
    }
    ```
