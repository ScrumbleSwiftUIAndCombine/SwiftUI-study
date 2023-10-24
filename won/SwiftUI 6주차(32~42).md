# SwiftUI 6주차 (32~42)

```swift
Color(UIColor.lightGray)
```

- UIColor 사용이 가능하다니..

### WebView Refresh 달기

```jsx
func makeUIView(context: Context) -> WKWebView {
    let myRefreshControler = UIRefreshControl()
    myRefreshControler.tintColor = .blue
    
    refreshHelper.viewModel = viewModel
    refreshHelper.refershControl = myRefreshControler
    
    myRefreshControler.addTarget(refreshHelper, action: #selector(WebViewRefreshControlHelper.didRefresh), for: .valueChanged)
    
    webview.scrollView.refreshControl = myRefreshControler
    webview.scrollView.bounces = true
}
```

### Coordinator

- SwiftUI에서 UIkit component의 Delegate사용하기 위해서 사용하는

```swift
struct RepresentTextField: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        func textFieldDidBeginEditing(_ textField: UITextField) {
            print("텍스트 필드 편집 시작")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
```

### TapGesture

```jsx
struct ContentView: View {

var singleTap: some Gesture {
        TapGesture()
            .onEnded { _ in
                print("한번 탭했다.")
            }
    }
}

var body: some View {
  VStack {
      Circle()
          .fill(Color.blue)
          .frame(width: 100, height: 100, alignment: .center)
          .overlay {
              Text("싱글탭")
                  .cirCleTitle()
          }
          .gesture(singleTap)
        }
}
```

### List Drag&Drop

```jsx

import SwiftUI

struct DataItem: Hashable, Identifiable {
    var id: UUID
    var title: String
    var color: Color
    
    init(title: String, color: Color) {
        id = UUID()
        self.title = title
        self.color = color
    }
}

struct ContentView: View {
    
    @State private var dataList = [
        DataItem(title: "1번", color: .yellow),
        DataItem(title: "2번", color: .green),
        DataItem(title: "3번", color: .orange)
        
    ]
    
    @State var isEditMode: Bool = false
    @State var draggedItem: DataItem?
    
    var body: some View {
        Toggle("수정모드", isOn: $isEditMode)
        LazyVStack {
            ForEach(dataList, id: \.self) { item in
                Text(item.title)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(item.color)
                    .onDrag {
                        self.draggedItem = item
                        return NSItemProvider(item: nil, typeIdentifier: item.title)
                    }
                    .onDrop(of: [item.title], delegate: MyDropDelegate(currentItem: item, dataList: $dataList, draggedItem: $draggedItem, isEditMode: $isEditMode))
                    
            }
        }
        .onChange(of: isEditMode) { newValue in
            print(newValue)
        } 
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyDropDelegate: DropDelegate {
    
    let currentItem: DataItem
    @Binding var dataList: [DataItem]
    @Binding var draggeditem: DataItem?
    @Binding var isEditMode: Bool
    

    init(currentItem: DataItem, dataList: Binding<[DataItem]>, draggedItem: Binding<DataItem?>, isEditMode: Binding<Bool>) {
        self.currentItem = currentItem
        self._dataList = dataList
        self._draggeditem = draggedItem
        self._isEditMode = isEditMode
    }
    
    
    
    // 드랍 벗어났을 때
    func dropExited(info: DropInfo) {
        
    }

    // 드랍 업데이트
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return nil
    }
    
    // Drop 처리
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    // 드랍 유효
    func validateDrop(info: DropInfo) -> Bool {
        return true
    }
    
    //드랍 시작
    func dropEntered(info: DropInfo) {
        
        if !isEditMode {return}
        guard let draggeditem = self.draggeditem else {return}
        
        // 드래깅된 아이템이랑 현재 내 아이템이랑 다르면
        if draggeditem != currentItem {
            let from = dataList.firstIndex(of: draggeditem)!
            let to = dataList.firstIndex(of: currentItem)!
            
            withAnimation {
                self.dataList.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            }
        }
        
    }
}
```

### 운영& 개발기 나누기

- 아이콘 변경

<img width="686" alt="6-1" src="https://github.com/Yoon-hub/Tuist_tutorial/assets/92036498/47afae03-27ad-4fc7-96a2-a1c5bce01589">


- bundle id 변경

<img width="690" alt="6-2" src="https://github.com/Yoon-hub/Tuist_tutorial/assets/92036498/93acd6ef-3e11-498f-9b26-7e2a852d5aae">


- Firebase setting

<img width="523" alt="6-3" src="https://github.com/Yoon-hub/Tuist_tutorial/assets/92036498/d208ecb0-3d43-478f-aeb0-ed8394c56543">


- edit Scheme 에서 현재 Build Configuration 확인

<img width="1304" alt="6-4" src="https://github.com/Yoon-hub/Tuist_tutorial/assets/92036498/2c70b947-2203-4dc7-98a6-cb7930a3b922">


- Display name 설정

<img width="530" alt="6-5" src="https://github.com/Yoon-hub/Tuist_tutorial/assets/92036498/31a9b0df-82d8-4a78-9f98-c070dbb090d3">


## Color Literal

```jsx
let  myRed = Color(#colorLiteral())
```

## Combine - Scheduler

- Publisher, Subject 공부했으니 마지막으로 Scheduler 공부해봅시다~
- 한줄 요약하면 - 어떤 스레드에서 동작할지 설정

```swift
let subject = PassthroughSubject<Int, Never>()

let token = subject.sink(receiveValue: { value in
      print(Thread.isMainThread) // true
})

subject.send(1)
```

- element가 생선된 스레드와 동일한 스레드

### Scheduler - **receive(on: ), subscribe(on:)**

- Thread Switching 해주는 오퍼레이터
- receive(on:): downstream의 스레드 변경
- subscribe(on:): • `subscribe(on:)`은 publisher, subscription과 같이 upstream 부분에 영향을 미친다.

```swift
let publisher = ["won"].publisher

publisher
    .map { _ in print(Thread.isMainThread) } // true
    .receive(on: DispatchQueue.global())  
    .map { print(Thread.isMainThread) } // false
    .sink { print(Thread.isMainThread) } // false
```

