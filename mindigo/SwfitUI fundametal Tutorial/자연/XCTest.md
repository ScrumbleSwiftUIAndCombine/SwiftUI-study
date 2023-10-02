#### XCTest 에 대해서 알아보자!
먼저! 많이 듣는 TDD가 무엇일까?
- TDD : Test Driven Development
기존의 설계 -> 개발 -> 테스트 순서가 아닌, 설계 -> 테스트 -> 개발의 순서로 작업을 하는 것을 말한다.
설계 문제로 인한 오류를 빠르게 잡아낼 수 있다는 장점이 있다고 한다.

- 단위 테스트 : Unit Test
    - 기능 단위의 코드를 작성하는 것이다. 즉, 모든 기능에 대한 테스트 케이스를 작성하는 절차를 말한다.
    - 단위테스트의 장점
        - 코드 변경으로 인한 디버깅을 빠르게 해준다

##### Unit Test 만들기
https://velog.io/@bibi6666667/TDD-%EB%8B%A8%EC%9C%84-%ED%85%8C%EC%8A%A4%ED%8A%B8-XCTest%EB%A1%9C-iOS-%EC%95%B1-%ED%85%8C%EC%8A%A4%ED%8A%B8%ED%95%98%EA%B8%B0

##### 테스트 케이스 작성하기 (Given, When, Then)
- 메서드 이름은 항상 test로 시작해야한다.
- 무엇을 테스트하는지에 대해 설명해야 한다.
- 테스트 메서드는 given, when, then 부분으로 나누어 작성하는 것이 좋다.
    - given : 테스트에 필요한 값을 설정하는 부분
    - When : 테스트할 코드를 실행하는 부분, 예를 들어 메서드를 실행한다.
    - Then : 테스트에 기대되는 결과값을 단정하는 부분 
        - https://developer.apple.com/documentation/xctest#2870839



### 🖖 네번째
> UI 테스트에 대해 알아보자

위에서 이제 유닛 테스트에 대해 알아보았으니, 이번에는 UI 테스트에 대해서 알아보도록 해보자

** UITest 란? **
User Interface Testing 이라는 뜻이다. 프레임워크를 사용하여 애플리케이션의 UI 요소를 자동화하여 UI 테스트를 실행할 수 있도록 해준다.

UITest의 장점은
 - 테스트 시작점이 빠르다.
 - 내부의 리소스 사용이 가능하다.

라는 장점들이 있다.

 
참고한 출처들
https://zeddios.tistory.com/1061
https://techblog.yogiyo.co.kr/%EC%9D%BC%ED%95%98%EA%B3%A0-%EC%9E%88%EC%8A%B5%EB%8B%88%EB%8B%A4-ios-ui-test-61830646d091