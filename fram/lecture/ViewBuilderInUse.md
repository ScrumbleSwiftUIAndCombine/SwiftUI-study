# ViewBuilder

### ViewBuilder란?
- custom parameter attribute 
> - custom : SwiftUI에 의해 정의된 것이 아닌 사용자 정의에 의해 단일 복합 뷰 생성 가능 </br>
>- parameter : 함수나 이니셜라이저 파라미터 앞에 위치하는 파라미터 속성</br>
>- attribute : 메타데이터, 추가 정보를 파라미터와 코드에 제공하는 역활

- 여러개의 뷰를 단일 복합 뷰

## 이점
#### 유연성
동적으로 뷰를 생성할 수 있음. 클로저 내부에서 조건문, 반복문을 사용하여 유연하게 대응 가능
상위 뷰에서 @ViewBuilder를 사용하여 어떠한 뷰도 전달 할 수 있기 때문에 유연하게 커스터마이즈 할 수 있음

#### 재사용성
커스텀 뷰를 생성하여 동일한 구성을 가지는 뷰에서 재사용 가능함

#### 코드 간결성
뷰 로직을 분리할 수 있기 때문에 복잡한 UI를 구성할 때 코드를 간결하게 할 수 있음
뷰를 작은 부분으로 쪼갠 뒤 조합하여 복잡한 UI를 구성할 수 있으며 유지보수 측면의 이점을 가짐

## 단점
#### 복잡성
View를 분리하므로서 생기는 복잡성으로 인해 코드와 동작 원리를 이해하기 힘들게 만들 수 있으며 가독성을 해칠 수 있음

#### 디버깅
여러 뷰 로직이 중첩되면서 캡슐화 되기 때문에 특정 데이터가 어디서 오고 어디서 사용되는지 추적하기 어려울 수 있음

#### 런타임 이슈
ViewBuilder가 생성하는 뷰의 갯수와 타입이 컴파일 타이밍에 결정되며 이는 타입 안정성과 런타임 이슈를 발생시킬 수 있음

## 정의
```swift
@inlinable public init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content)
```

정의를 보면 파라미터로 @ViewBuilder가 붙은 것을 확인할 수 있고 이 파라미터는 클로저를 통해 여러 단일 뷰를 전달 받는다. 뷰 빌더로 부터 전달된 단일 뷰들로 복합 뷰를 생성할 수 있다. ViewBuilder를 사용하면 일종의 custom container를 만들 수 있다. 

ViewBuilder를 사용해서 커스텀 컨테이너를 생성할 때 다른 파라미터 인자로 부터 필요한 디펜던시를 함께 전달 받을 수 있다. 

## 예제코드
```swift
struct NormalView<Content: View>: View { // 제네릭으로 View를 Content로
    let title: String
    let buttonName: String
    let content: () -> Content // 클로저로 전달 받음
    
    init(title: String, buttonName: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.buttonName = buttonName
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(title)
                    .font(.system(.headline))
                    .fontWeight(.bold)
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 44, height: 44)
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 14)
                    
                    Spacer()
                } //: HStack
            } //: ZStack
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            
            Spacer()
            
            content()
            
            Spacer()
            
            Button {
                
            } label: {
                Text(buttonName)
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(.black)
            }
        }
    }
}

```

```swift
struct NormalView_Previews: PreviewProvider {
    static var previews: some View {
        NormalView(title: "제목", buttonName: "버튼이름") {
            Text("테스트")
        }
    }

```
preview를 설정해서 보면 공통적으로 사용할 화면 영역을 ViewBuilder 를 이용한 View로 지정할 수 있으며 클로저를 통해 표시할 뷰를 전달할 수 있음

```swift
struct ProductDetailView: View {
    var body: some View {
        NormalView(title: "상품 상세", buttonName: "구입하기") {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.frame(in: .global).size.width - 48)
                        .frame(height: geometry.frame(in: .global).size.width - 48)
                        .foregroundColor(.yellow)
                    
                    Text("가격 : 20,000")
                }
                .padding(.horizontal, 24)
            }
        } //: NormalView
    }
}
```
실제 사용할 때는 중복되는 뷰 코드를 작성할 필요가 없어 재사용성을 높이고 복잡한 뷰 코드를 간결

## 응용
가로, 세로 화면에 대응할 수 있음
```Swift
struct InfoView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("암호 입력")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("카카오톡 암호를 입력해 주세요.")
                .foregroundStyle(.gray)
                .font(.system(size: 14))
                .padding(.bottom, 18)
            
            HStack(spacing: 20) {
                ForEach(0..<4) { index in
                    Image(systemName: "circle")
                }
            }
        }
    }
}
```

```swift
struct KeypadView: View {
    let numbers = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [" ", "0", " "]
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<numbers.count, id: \.self) { rowIndex in
                HStack(spacing: 0) {
                    ForEach(0..<numbers[rowIndex].count, id: \.self) { columnIndex in
                        Button {
                            print(numbers[rowIndex][columnIndex])
                        } label: {
                            if rowIndex == numbers.count - 1 && columnIndex == numbers[rowIndex].count - 1 {
                                Image(systemName: "eraser")
                                    .keypadButtonStyle()
                                    
                            } else {
                                Text("\(numbers[rowIndex][columnIndex])")
                                    .keypadButtonStyle()
                            }
                        } //: Button
                    }
                }
            } //: ForEach
        } //: VStack
    }
}

struct KeypadButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(.black)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
    }
}
```
각 컴포넌트를 View로 나눔
```swift
struct LandscapeManageView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack {
                    content
                } //: VStack
            } else {
                HStack(alignment: .center) {
                    content
                } //: HStack
                .frame(maxHeight: .infinity)
            }
        } //: GeometryReader
    }
}
```
GeometryReader와 ViewBuilder를 사용해서 가로 화면과 세로 화면 분기처리

```swift
struct ContentView: View {
    
    var body: some View {
        LandscapeManageView {
            Spacer()
            InfoView()
            Spacer()
            KeypadView()
        }
    }
}
```
실제 구현부는 간단하게 표현할 수 있음