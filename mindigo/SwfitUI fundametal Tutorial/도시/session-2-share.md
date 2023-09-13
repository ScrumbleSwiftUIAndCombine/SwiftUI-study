강의 #1 ~ #7 까지의 내용 정리 및 알게 된 내용 공유하고 싶은 내용 정리

> 😇 강의를 듣가다 궁금했던 점 위주로 정리되어 있습니다.

#### 👆 첫번째 (#1)
❓ `background(Color.blue)` 의 속성을 준 다음 `padding`을 줄 경우 바깥의 `padding` 이 적용되지 않는다?

❗ 그 이유는 속성이 적용된 순서가 다르기 때문이다.

`Hstack`의 속성이 `background(Color.blue)` -> `padding(30)` 순으로 되어있다면, `padding`이 지정되지 않은 상태로 `background`를 적용했기 때문에 원래 요소들의 크기 만큼 `padding`이 적용된 것이다.

반대로, `HStack`의 속성이 `padding(30)` -> `background(Color.blue)` 의 순서로 되어있다면, 현재 뷰에 `padding`이 지정되어 있기 때문에 그 해당 `padding`까지 뷰의 영역으로 보고 색상을 적용한다.

그래서 이 모든걸 합쳐보면 노란색과 파란색의 영역이 다른 걸 확인할 수 있다.
```swift
HStack {
	VStack { ... }
}
.background(Color.yellow)
.padding(30)
.background(Color.blue)
```
<img  src="https://github.com/mingging/swiftui-daily-digest/blob/main/mindigo/SwfitUI%20fundametal%20Tutorial/assets/%231_1.png?raw=true"  width="450px"  height="300px"  title="px(픽셀) 크기 설정"></img><br/>

이렇듯 속성의 순서 또한 SwiftUI에서는 중요한 요소 중 하나다!

<br><br>

#### ✌ 두번째 (#2)
❓ SwiftUI에서 주로 조건문을 작성할 때 삼항연산자를 사용한다. 그럼 if문은 사용할 수 없을까?

❗ 사용할 수 있지만 동작 방식이 다르다

SwiftUI에서 삼항연산자는 표현식으로 취급되어 `return` 키워드가 필요없지만, `if`문은 구문으로 구분되기 때문에 `return`이 꼭 필요하다.

만약 다음과 같은 코드가 있다고 하자.
```swift
Text("안녕하세요").background(Color.red)
```

나는 이 코드를 `isActivated` 값에 따라 `background` 색을 변경하고 싶다.   
그렇다면 기존 삼항연산자를 사용하면 이렇게 표현할 수 있다.

```swift
Text("안녕하세요").background(isActivated ? Color.red : Color.yellow)
```

그렇다면 `if`문으로 표현한다고 하면 어떻게 해야할까? 이렇게 할 수 있을 것이다.

```swift
if isActivated {
	return  Text("안녕하세요").background(Color.red)
} else {
	return  Text("안녕하세요").background(Color.yellow)
}
```

여기서 알 수 있는 것은 삼항연산자를 사용했을 때보다 코드의 길이가 2배 이상 늘어났다는 것이다. 그리고 내가 원하는 건 겨우 `background`의 색을 바꾸는 것 뿐인데, `background`의 색을 변경하기 위해서 `Text` 까지 다시 만들어줘야하는 건 효율적이지 못하다.   
물론 어떤 경우에서는 `if`문을 사용해야할 수도 있지만 간단한 코드라면 삼항연산자를 이용하는 것이 더 이득일 것이다.

<br><br>

#### 🤟 세번째 (#2)
❓ `maxWidth: .infinity`는 무슨 뜻일까?

❗ 말 그대로 무한대를 의미하며 `maxWidth: .infinity` 라는 말은 곧 `width`의 무한 영역까지 넓히겠다는 의미로 받아들이면 될 것 같다.