### #47

```swift
// 스플래시 화면 만들어주기
extension ContentView {
	var mySplashScreenView: some View {
		Color.yellow.edgeIgnoringSafeArea(.all)
			.overlay(alignment: .center) {
				Text("스플래시입니다")
					.font(.largeTitle)
			}
	}
}
```

- 실제로 적용할 때 flag 값을 이용해서 스플래시를 띄워준다.

```swift
ZStack {
    Text("Hello, world!")
        .padding()
    
    if !isContentReady {
        mySplashScreenView.transition(.opacity)
    }
}
.onAppear {
    print("ContentView - onAppear() called")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        print("ContentView - 1.5초 뒤")
        withAnimation { isContentReady.toggle() }
    }
}
```

**LottieAnimation**

[GitHub - airbnb/lottie-ios: An iOS library to natively render After Effects vector animations](https://github.com/airbnb/lottie-ios)

[LottieFiles: Download Free lightweight animations for website & apps.](https://lottiefiles.com/)

### #48

- UIKit에 있는 걸 SwiftUI로 가져온다.

[GitHub - siteline/swiftui-introspect: Introspect underlying UIKit/AppKit components from SwiftUI](https://github.com/siteline/swiftui-introspect)

```swift
.introspect(.scrollView, on: .iOS(.v14), customize: { scrollView in
    scrollView.delegate = scrollViewHelper
})
```

```swift
class ScrollViewHelper: NSObject, UIScrollViewDelegate, ObservableObject {
    @Published var isBottomValue: Bool = false
    
    var threshold: CGFloat = 0
    
    init(_ threshold: CGFloat = 0) {
        self.threshold = threshold
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll \\(scrollView.contentOffset.y)")
        
        self.isBottomValue = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height < threshold
    }
}
```

### #50

- `trim`
    - from ~ to : 어디부터 어디까지 자를것인지

```swift
.trim(from: 0.0, to: 0.8)
```

- 돌리기

```swift
@State var currentDegress = 0.0

.rotationEffect(Angle(degress: currentDegress))
.onAppear(perform: {
	Timer.scheduledTimer(withTimeIntervale: 0.02, repeats: true, block: { _ in
		withAnimation {
			self.currentDegress += 5
		}
	}
})
```

- storkeStyle

```swift
.stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
```

- Gradient

```swift
LinearGradient(gradient: Gradient(colors: [
	Color.blue,
	Color.blue.opacity(0.75),
	Color.blue.opacity(0.5),
	Color.blue.opacity(0.2),
	.clear
]), startPoint: .leading, endPoint: .trailing)
```

### #51

- `redacted` : 데이터가 없을 때 스켈레톤 뷰를 덮어씌워준다.
- `unredacted` : 스켈레톤 뷰를 적용하지 않는다.

### #이모저모

**SVG는 정답일까? 그럼 PNG는?**

- 애플은 이미지들이 제대로 들어있지 않을 경우 앱을 리젝해버리기도 한다.
    
- 유저들에게 완벽한 이미지를 제공하기 위해서는 3가지 타입의 디스플레이를 가진 디바이스를 지원해야 한다.
    
    - Retina Display를 탑재하지 않은 디바이스
        - (iPhone 4 이전 모델들)
    - Retina Display를 탑재한 디바이스
        - (iPhone 4 ~ iPhone 5)
    - Retina HD Display를 탑재한 디바이스
        - (iPhone 6 ~ 현재)
- 앱의 용량을 걱정할 필요는 없다. 유저가 앱을 다운로드할 때 thinning을 통해 필요한 imageAsset만을 받기 때문이다.
    
- **SVG의 등장**
    
    - 이미지 Asset 개수와 용량이 확연하게 줄어드는 장점
    - Vector Image
    - XML(Extensible Markup Language)로 짜여져있다.
    - SVG 파일을 개발자가 직접 수정할 수도 있다.
    - SVG는 PNG에 비해 용량도 적게 차지한다.
- **그렇다면 주의할 점은?**
    
    - Xcode12 이상부터 지원한다.
    - App Target이 iOS 13, iPadOS 13, macOS 10.15 이상이여야한다.
    - 복잡한 이미지일수록 크기가 커질 수 있어 오히려 PNG로 처리하는 것이 더 유리하다.
    - 정확한 이미지 색을 표현하기 위해서는 PNG를 통해 노출시키는 편이 더 효과적이다.
    - Gradation이 있을 경우 안정성을 위해 PNG로 관리하길 권장한다.
        - 비어있는 화면으로 나오는 버그가 있다.
    - 리사이징이 필요한 경우 Preserve Vector Data Check가 필요하다.
- **그럼 어느 때 SVG, PNG를 써야하는가?**
    
    - 정답은 없다. 적재적소에 맞게 사용하면 된다.
    - 이미지가 단순하고, gradation 등의 추가적인 요소들이 적을 때에는 **SVG**
    - gradation 등의 요소가 있어 안정성에 문제가 될 수 있다 판단되면 **PNG**

**18만개의 아이콘을 무료로 활용할 수 있는 Iconbuddy**

출처 : [https://yozm.wishket.com/magazine/detail/2165/](https://yozm.wishket.com/magazine/detail/2165/)

[Iconbuddy — 180K+ open source icons](https://iconbuddy.app/)
