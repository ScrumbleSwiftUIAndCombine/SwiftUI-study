@State로 프로퍼티를 감싸주게 되면 이 프로퍼티의 값이 변경될 때,
자동으로 UI도 업데이트 해주겠다~ 선언하는 거임!

그러니까 뷰가 가진 프로퍼티의 상태(State)를 지켜보겠다~는 말

```swift
import SwiftUI

struct StateBootcamp: View {
    
    @State var backgroundColor: Color = .green
    @State var myTitle: String = "My Title"
    @State var count: Int = 0
    
    var body: some View {
        ZStack {            
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(myTitle)
                    .font(.title)
                Text("Count: \(count)")
                    .font(.headline)
                    .underline()
                
                HStack(spacing: 20) {
                    Button("Button 1") {
                        backgroundColor = .blue
                        myTitle = "Button 1 was Pressed"
                        count += 1
                    }
                    Button("Button 2") {
                        backgroundColor = .gray
                        myTitle = "Button 2 was Pressed"
                        count -= 1
                    }
                }
            }
            .foregroundColor(.white)
        }
    }
}
```

>SwiftUI에서 View에 `var`을 직접 사용할 수 없는 이유는 SwiftUI의 데이터 흐름과 뷰 갱신 메커니즘에 관련이 있습니다.

SwiftUI는 선언적인 방식으로 UI를 구성하기 위해 설계되었으며, 이는 데이터의 상태 변화에 따라 자동으로 뷰를 갱신하는 것을 목표로 합니다. 따라서 SwiftUI에서 뷰를 구성하는 속성이나 변수들은 데이터의 상태를 나타내기 위해 특정한 방식으로 관리되어야 합니다.

`var`를 직접 사용하는 것은 값의 변화가 어디서든 발생할 수 있기 때문에 SwiftUI의 갱신 메커니즘을 일관되게 동작시키기 어렵게 만듭니다. SwiftUI는 뷰의 상태 변화를 추적하고, 변경된 상태만 갱신하는 효율적인 업데이트를 수행하기 위해 필요한 정보를 알아야 합니다. 그러나 `var`를 사용하면 값의 변화를 추적하기 어렵고, 어느 부분에서 값이 변경되었는지를 파악하기 어렵기 때문에 이러한 기능을 제공할 수 없습니다.

대신 SwiftUI에서는 `@State`, `@Binding`, `let`과 같은 속성 래퍼를 사용하여 값을 관리합니다. `@State` 속성 래퍼는 특정한 뷰 내에서 해당 값이 변경될 때마다 SwiftUI에게 알리는 역할을 합니다. `@Binding` 속성 래퍼는 다른 뷰와 값을 공유하면서 변경 사항을 전파하는 데 사용됩니다. `let`은 뷰가 상수 값을 가질 때 사용됩니다.

이러한 속성 래퍼들은 SwiftUI의 데이터 흐름과 뷰 갱신 메커니즘을 지원하기 위해 설계되었으며, 값을 갱신하거나 변경 사항을 추적하는 데 필요한 내부 동작을 수행합니다. 이를 통해 SwiftUI는 효율적인 뷰 업데이트를 달성하고 일관된 상태 관리를 제공할 수 있습니다.


___

## Extract Functions & Views

```swift
struct ExtractedFunctionBootcamp: View {
    
    @State var backgroundColor: Color = Color.green
    
    var body: some View {
        ZStack {
            //background
            backgroundColor
                .ignoresSafeArea()
            
            //content
            contentLayer
        }
    }
    
    var contentLayer: some View {
        VStack {
            Text("Title")
                .font(.largeTitle)
            Button {
                buttonPressed()
            } label: {
                Text("Press me")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
            }
        }
    }
    
    func buttonPressed() {
        backgroundColor = .yellow
    }
}

```

변수로 빼서 view를 구성하면 body가 짧아지면서 가독성이 좋아짐  
extension으로 빼서 구성해주면 더 읽기 좋다!!  

view나 function은 따로 분리 가능  

![](https://velog.velcdn.com/images/woojusm/post/3926a33c-c04e-42f0-ba88-f369e9a24b79/image.png)  
이렇게 직접 스택 자체를 Extract도 가능하다  
커맨드 클릭!  

___

## Extract Subviews

앞에서 했던 `var contentLayer: some View` 로 나누는건 여러개의 뷰를 표현하기가 불편하다  

그래서 structure로 아예 빼버리는 방법이 있음  

```swift
struct MyItem: View {
    let title: String
    let count: Int
    let color: Color
    var body: some View {
        VStack {
            Text("\(count)")
            Text(title)
        }
        .padding()
        .background(color)
        .cornerRadius(10)
    }
}

struct ExtractSubviewBootcamp: View {
    var body: some View {
        ZStack {
            Color(.systemTeal).ignoresSafeArea()
            
           contentLayer
        }
    }
    
    var contentLayer: some View {
        HStack {
            MyItem(title: "Apples", count: 1, color: .red)
            MyItem(title: "Oranges", count: 10, color: .orange)
            MyItem(title: "Bananas", count: 34, color: .yellow)
        }
    }
}
```
요렇게!


___
# @Binding

부모뷰랑 child View가 있다고 해봅시다  

부모뷰에 선언된 프로퍼티를 child View는 알 수가 없음  
프로퍼티의 스코프는 선언된 곳에 한정되니까  

새로 변수를 파서 값을 전달해줘도 되겠지만 그럼 여러개의 상태들을 계속해서 만들어주고 값도 전달해줘야해요  

이럴 때 @Binding 프로퍼티 래퍼를 사용하면 부모뷰가 가진 [@State로 선언된] 프로퍼티를  
말 그대로 바인딩 해줄 수 있습니다.  

그리고 부모뷰에서 자식뷰를 호출하게 되었을 때 $ 사인을 붙여서 값을 넘겨주면 됩니다  

```swift
struct BindingBootcamp: View {
    
    @State var backgroundColor: Color = .green
    @State var title: String = "Title"
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            VStack {
                Text(title)
                    .foregroundColor(.white)
                ButtonView(backgroundColor: $backgroundColor, title: $title)
            }
        }
    }
}

struct ButtonView: View {
    @Binding var backgroundColor: Color
    @State var buttonColor: Color = .blue
    @Binding var title: String
    var body: some View {
        Button {
            backgroundColor = .orange
            buttonColor = .pink
            title = "New Title!"
        } label: {
            Text("Button")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(buttonColor)
                .cornerRadius(10)
        }
    }
}
```

### Preview에는 .constant로 값이 들어가야하구요!


