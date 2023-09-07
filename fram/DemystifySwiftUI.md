# Demisty SwiftUI

### 👉 Intro
- SwiftUI는 선언형 UI 프레임워크 (ex HTML, CSS, SQL 등) How가 아닌 What
- identity
  > 앱이 업데이트 될 때 elements를 같은 것으로 인식하는지 혹은 구별하는지에 대한 방법
- lifetime
  > 시간의 흐름에 따라 어떻게 뷰와 데이터의 존재 여부를 추적하는지에 관한 것
- dependencies
  > 인터페이스가 언제 업데이트를 필요로 하며 왜 업데이트를 필요로 하는지
- identify, lifetime, dependencies는 "무엇을", "언제", "어떻게" 변경해야 하는가를 나타내며 최종적으로 사용자에게 동적인 인터페이스를 제공할 수 있음

### 💳 View Identity
- 겉으로 보기에 동일한 두 개의 사물을 찍은 사진이 있다고 하자. 이때 이 사진 속 사물은 같은 사물일까? 아니면 동일한 사물을 찍은 두 장의 사진일까? 각 사물을 구분하는 고유 값 그것이 Identity의 핵심
- SwiftUI에서는 다른 상태(state)에 있는 뷰들이 identity라는 것으로 연결되어 있음. 같은 개념적 UI 요소의 다른 상태를 나타내기 위해서 같은 ID를 공유함
- same identity == same element : 같은 개념적 UI 요소의 다른 상태를 나타내기 위해서 같은 ID를 공유함
- different identities == distinct element : 구별되는 UI (다른 UI)인 경우 다른 아이디 값을 가짐

#### Explicit identity
- SwiftUI는 참조가 아닌 값 타입이기 때문에 사용할 수 있는 고유 참조값이 없음. (UIKist은 각 View가 참조값을 가지고 있기 때문에 만일 두 개의 뷰가 동일한 지 확인하려면 참조값을 비교하면 됨)

~~~Swift
Section {
    ForeEach(users, id:\.userID) { user in
        ListRowView(id)
    }
}
~~~
- id 파라미터로 전달한 고유값은 각 뷰를 명시적으로 구분할 수 있게 함
- 섹션내에서 해당 뷰를 이동 시키더라도 SwiftUI는 ID를 사용해서 무엇이 변경되었는지 파악하고 애니메이션을 수행할 수 있음