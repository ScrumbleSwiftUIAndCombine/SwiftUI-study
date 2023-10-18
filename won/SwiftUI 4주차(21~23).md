# SwiftUI 4주차(21~23)

### Navaigation Menu 만들기

```swift
struct ContentView: View {
    
    let myPet = ["멍멍이", "야옹이", "뮹융이"]
    
    @State private var shouldAlert: Bool = false
    @State private var text = ""
    @State private var selected: Int = 0
    
    var body: some View {
        NavigationView {
            Text(myPet[selected])
                .font(.system(size: 60))
                .fontWeight(.bold)
            .navigationTitle("하이요")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu { // VStatck 처럼 동작
                        Button {
                            print("버튼클릭")
                            self.text = "첫번째 버튼"
                            self.shouldAlert = true
                        
                        } label: {
                            Label("풀타올라", image: "flame.fill")
                        }
                        
                        Button {
                            print("버튼클릭")
                            self.text = "두번째 버튼"
                        } label: {
                            Label("집에", image: "person")
                        }
                        
                        Section {
                            Button {
                                print("섹션 버튼")
                                self.text = "섹션 버"
                            } label: {
                                Label("집에", image: "person")
                            }
                        }
                        
                        Button {
                            print("버튼클릭")
                            self.text = "네번째 버튼"
                        } label: {
                            Label("집에", image: "person")
                        }
                        
                        Button {
                            print("버튼클릭")
                            self.text = "네번째 버튼"
                        } label: {
                            Label("집에", image: "person")
                        }

                        Picker(selection: $selected, label: Text("피커")) {
                            ForEach(myPet.indices, id: \.self) { index in
                                Text(myPet[index])
                            }
                        }
                    

                    } label: {
                        Circle()
                            .foregroundColor(Color.yellow)
                            .frame(width: 50, height: 50)
                            .overlay (
                                Label("메뉴", systemImage: "gear")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            )
                    }
                }
            }
            .alert(isPresented: $shouldAlert) {
                Alert(title: Text("알림창"))
            }
        }
    }
}
```

### LazyVGride

- **`LazyVGrid`**는 SwiftUI에서 사용되는 뷰 컨테이너 중 하나로, 세로 방향(Vertical)으로 스크롤 가능한 그리드 형태의 레이아웃을 구성하는 데 사용됩니다.

```swift
import SwiftUI

enum LayoutType {
    case half
    case full
}

extension LayoutType {
    
    var column: [GridItem] {
        if self == .half {
            return [GridItem(.fixed(100)),
            //GridItem(.adaptive(minimum: 50)),
            GridItem(.flexible(minimum: 50))]
        } else {
            return [GridItem(.flexible(minimum: 50))]
        }
    }
}

struct MyPickerGrideView: View {
    
    @State private var selectionValue: LayoutType = .half
    
    let myData = Array(1...2000).map { return "\($0)번" }
    var body: some View {
        
        VStack {
            
            Picker(selection: $selectionValue) {
                Image(systemName: "bag").tag(LayoutType.half)
                Image(systemName: "bag.fill").tag(LayoutType.full)
                Image(systemName: "creditcard").tag(LayoutType.full)
                
            } label: {
                
            }
            .pickerStyle(.segmented)
            .frame(width: 300)
            ScrollView {
                //Column은 호리젠탈 아이템 레이아웃을 설정하는 부분
                // .fixed 고정
                // .adapative 여러개 채우기 - 채울수 있을 만큼 채우기
                // . flexible은 하나만 채우기 - 하나를 끝까지 채우기
                LazyVGrid(columns: selectionValue.column, alignment: .center, spacing: 10) {
                     
                    ForEach(myData, id: \.self) {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor( self.selectionValue == .half ? .blue : .green)
                            .overlay(
                                Text($0)
                            )
                    }
                }
                .animation(.some(.linear))
            }
        }

    }
}
```

## REDUX

![4주차 이미지](https://github.com/Yoon-hub/SwiftUITutorialProject/assets/92036498/9b2b6c34-2ec6-4947-93b2-fff1006f716c)

- Store 에서 앱전체의 상태를 가지고 있다
    - Store의 상태가 변경이 되면 UI도 변경이 된다.
- Action은 Action
- Reducer는 Action을 필터링

### Private(set)

```swift
private(set) var state: State // 외부에서는 읽기만 가능
```

### inOut

- 매개변수 변경을 위한 키워드

### @**EnvironmentObject**

- SwiftUI에서 데이터를 뷰에 주입하는데 사용
- 모든 뷰에서 접근이 가능하다.

### **ObservableObject**

- 클래스에 채택할 수 있는 프로토콜로, 객체의 속성 변경 사항을 감지하고 해당 변경을 뷰에 통지할 수 있도록 해준다.
- `@Published` 속성을 사용하여 객체의 변경을 감지하고 뷰를 업데이트
