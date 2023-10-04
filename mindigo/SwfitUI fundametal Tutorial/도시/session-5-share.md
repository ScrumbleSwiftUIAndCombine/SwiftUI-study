> 😇 강의를 듣가다 궁금했던 점 위주로 정리되어 있습니다.

### 👆 첫번째 (#21)
❓ ForEach 문에서 사용하는 indices 는 뭘까?

❗ 컬렉션을 오름차순으로 구독하는 데 유효한 인덱스이다.

<br><br>

### ✌ 두번째 (#22)
❓ ForEach 를 좀 더 자세히 알아보자

❗ SwiftUI 의 ForEach 는 struct 구조 이므로 본문에서 직접 반환할 수 있다.
for-in을 사용하게 되면 에러가 발생하게 되는데, 이때 뜨는 에러는 다음과 같다.

>Closure containint control flow statement cannot be used with result builder 'ViewBuilder' 
>조건문을 포함하는 클로저는 result builder인 'ViewBuilder'와 함께 쓰일 수 없다.

이게 무슨 뜻일까? 
VStack의 이니셜라이저를 보면 VStack의 클로저는 Content를 리턴해야 한다고 한다.
그런데 for-in의 경우는 단순히 for문만 돌리고 있기 때문에 에러가 나는 것이다.
공식 문서에서의 ForEach 는 식별된 데이터의 콜렉션으로부터 요구에 따라 뷰를 계산해주는 구조체라고 정의되어있다.
ForEach는 3개의 파라메터가 필요한데, data, id, content 로 나뉘어져있다.
SwiftUI는 효율적으로 뷰를 새로 그리기 위해 바뀐 부분만 새로 그리게 된다. 그러기 위해서는 각 요소마다 고유값이 필요한데, 이때 고유값으로 id를 설정해준다. 
만약 단순 문자열을 사용하고 싶다면 별다른 고유 id가 없기 때문에 `\.self` 를 통해 구분할 수 있다. 그러나 이 경우 같은 문자열을 사용한 경우 같은 id로 인식되기 때문에 수정시에 동시적으로 변경되게 된다.


결론적으로 말하자면 SwiftUI 에서의 **ForEach 문은 View**이다.


출처 : https://velog.io/@nala/SwiftUI-ForEach-%EB%84%88%EB%8F%84-View%EB%83%90
https://velog.io/@nala/SwiftUI-ForEach-%EB%84%88%EB%8F%84-View%EB%83%90

<br><br>

### 🤟 세번째 (#23)
❓ .animation(diceRollAnimation, value: shouldRoll)

❗ 영상에서는 value가 없는 기본 animation을 썼지만 iOS 15.0 에서 deprecated 된 친구이다. 이때 withAnimation 또는 위와 같이 사용할 수 있는데 value 의 값이 변경될 때만 애니메이션이 실행되도록 된다.

<br><br>
