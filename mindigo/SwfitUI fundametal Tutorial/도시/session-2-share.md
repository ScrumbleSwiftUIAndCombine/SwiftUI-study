> 😇 강의를 듣가다 궁금했던 점 위주로 정리되어 있습니다.


### 👆 첫번째 (#1)
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
<img  src="https://github.com/mingging/swiftui-daily-digest/blob/main/mindigo/SwfitUI%20fundametal%20Tutorial/assets/%231_1.png?raw=true"  width="450px"  height="300px"  title=""></img><br/>

이렇듯 속성의 순서 또한 SwiftUI에서는 중요한 요소 중 하나다!

<br><br>

### ✌ 두번째 (#2)
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

### 🤟 세번째 (#2)
❓ `maxWidth: .infinity`는 무슨 뜻일까?

❗ 말 그대로 무한대를 의미하며 `maxWidth: .infinity` 라는 말은 곧 `width`의 무한 영역까지 넓히겠다는 의미로 받아들이면 될 것 같다.

<br>
<hr>

### 🌿 오늘의 민트 주간
#### 🌳 Xcode에서 맞춤법 검사 방법
출처 : https://ios-development.tistory.com/m/1497

#### 오타를 찾아보자
현재 열려있는 파일에서 cmd + ; 를 누르면 오타로 의심되는 위치에 포커스를 띄워준다.
한번 더 누르게 되면 다음 오타로 의심되는 부분으로 포커스가 이동한다.

<img src="https://github.com/mingging/swiftui-daily-digest/blob/main/mindigo/SwfitUI%20fundametal%20Tutorial/assets/mint_1.png?raw=true" title=""></img><br/>


#### 오타를 수정해보자
해당 포커스에서 control + 오른쪽 마우스 클릭을 하면 추천 단어들이 뜨게 된다.
그 중에서 원하는 단어를 누르면 해당 단어로 바뀌게 된다.

<img src="https://github.com/mingging/swiftui-daily-digest/blob/main/mindigo/SwfitUI%20fundametal%20Tutorial/assets/mint_2.png?raw=true" title=""></img><br/>

<br>

#### 🌳 Xcode 단락 묶기
출처 : 카카오톡 오픈 채팅방

가끔 코딩을 하다보면 너무 긴 단락 탓에 접고 싶을 때가 있다. 그러면 cmd + alt + 방향키를 이용해 단락을 접으면 되지만 이 기능은 그 뿐만이 아니라 어디서 부터 어디까지가 한 단락인지 알고 싶을 때 사용하면 유용할 것 같다고 생각이 되었다.

설정 방법은 엄청 간단하다
Xcode -> Setting -> Text Editing 에 가면 Code folding ribbon 이라는 항목이 있다.
해당 항목을 선택할 경우 아래와 같은 폴딩을 할 수 있는 버튼이 나타나게 된다.
해당 줄? 에 마우스를 올리면, 어디서 어디까지가 단락인지 알 수 있으며 손 쉽게 단락을 닫을 수 있다!

<img src="https://github.com/mingging/swiftui-daily-digest/blob/main/mindigo/SwfitUI%20fundametal%20Tutorial/assets/mint_3.png?raw=true" title=""></img><br/>

