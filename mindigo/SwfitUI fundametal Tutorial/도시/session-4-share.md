> 😇 강의를 듣가다 궁금했던 점 위주로 정리되어 있습니다.

  

### 👆 첫번째 (#8)

❓ 왜 아이콘 크기는 font Size 로 변경할까?

❗ SF Symbols을 사용해 아이콘을 표시할 때는 font size로 지정해야한다.

.. 아직 뭔지 잘 모르겠다 아시는분..?

<br><br>

### ✌ 두번째 (#12)

❓ GeometryReader에 대해 조금 더 자세히 알아보자

먼저, GeometryReader 에 대해 더 알아보자고 결심하게 된 계기는 항상 많이 쓰던 것들인데 사용법과 의미를 잘 모르고 사용하고 있다는 생각이 문득 들어서이기 때문이다.
그래서 이번 기회에 어떤 상황에 쓰이고, 어떤 식으로 사용할 수 있는지 알아보고자 한다.

  <br>

**GeometryReader 란?**

컨텐츠의 크기와 위치를 함수로 나타내는 컨테이너 뷰,
VStack, HStack, ZStack과 같은 View Builder 에 하위 뷰들을 넣게 되면 별도의 설정 없이 화면에 자동으로 보여준다.
Parent View 상위 뷰가 Child View 하위 뷰에게 위치와 크기를 제안해주기 때문이다.
그러나 마음에 들지 않을 때 하위 뷰는 상위 뷰의 제안을 무시하고 선언할 수 있다.
이 때, GeometryReader가 사용된다.
GeometryReader를 초기화하는 방법은 GeometryProxy를 이용해 만든다.

 <br>

**GeometryProxy를 란?**

컨테이너 뷰의 좌표나 크기를 접근할 수 있는 것
frame(in:), size, safeAreaInsets를 이용해 GeometryReader의 레이아웃 정보를 자식 뷰에게 제공할 수 있다.

<br><br>  
  

### 🤟 세번째
> 유닛 테스트에 대해 알아보자

저번에 미쳐 다 소개하지 못한 UITest, UnitTest에 대해서 소개해보려고 한다.
위에서 말했듯이 테스트의 종류는 두 가지가 있다. UITest와 UnitTest, 말 그대로 UITest는 UI를 테스트하는 것이며 UnitTest는 기능 단위를 테스트하는 것이다.
먼저 UnitTest 부터 알아보자,

<br>

**유닛 테스트란,**

컴퓨터 프로그래밍에서 소스 코드의 특정 모듈이 의도된 대로 정확히 작동하는지 검증하는 절차, 즉 모든 함수와 메소드에 대한 테스트 케이스(Test case)를 작성하는 절차를 말한다.
기능 단위의 테스트 코드를 작성하며, 코드 변경으로 인한 디버깅을 빠르게 해줄 수 있다.
단위 테스트를 믿고 리팩토링을 편하게 할 수 있으며, 리팩토링 후 단위테스트로 재검증이 가능하다.

<br>

유닛 테스트에는 원칙이 있다.
- **Fast** : 유닛 테스트는 빨라야한다.
- **Isolated** : 다른 테스트에 종속적인 테스트는 절대로 작성하지 않는다.
- **Repeatable** : 테스트는 실행할 때마다 같은 결과를 만들어야 한다.
- **Self-validation** : 테스트는 스스로 결과물이 옳은지 그른지 판단할 수 있어야 한다. 테스트는 완전히 자동화되어야 한다. 결과를 해석할 필요 없이 pass 또는 fail을 출력하게 한다.
- **Timely** : 테스트 코드는 개발 전에 작성해야 한다.

<br>

유닛 테스트는 아래와 같이 이뤄지게 된다.
```swift
func  testArraySorting() {
	let input = [1, 7, 6, 3, 10]
	let expectation = [1, 3, 6, 7, 10]
	let result = input.sorted()
	XCTAssertEqual(result, expection)
}
```
위 코드는 input을 sorted 했을 때 expectation의 값과 같은 지를 테스트 하는 코드다. 그런데 여기서 나오는 XCTAssertEqual 이건 뭘까?

<br>  

#### XCTest
유닛 테스트, 퍼포먼스 테스트, UI테스트를 만들고 실행하는 프레임워크다.
Xcode에서 처음 프로젝트를 만들 때 'Include Tests' 의 항목을 선택하고 프로젝트를 생성하게 된다면 자동적으로 XCTest 를 포함한 프로젝트를 만들어준다.

<br>

**XCTestCase**
XCTest의 하위 클래스로, 테스트를 작성하기 위해 상속해야 하는 가장 기본적인 클래스이다.

#### setUpWithError()
각각의 test case가 실행되기 전마다 호출되어 각 테스트가 모두 같은 상태와 조건에서 실행될 수 있도록 만들어준다.
즉, 테스트 메소드가 실행되기 전 모든 상태를 reset 한다.
<br>
#### tearDownWithError()
각각의 test 실행이 끝난 후 마다 호출되는 메서드로, 보통 setUpWithError() 에서 설정한 값들을 해제할 때 사용된다.
즉, 테스트 동작이 끝난 후 모든 상태를 clean up 한다.
<br>
❗❗ 테스트 메소드는 반드시 **test** 키워드로 시작해야 한다.
<br>

테스트 포맷은 given - when - then 구조로 작성하는 것이 좋다.
- **given** : 테스트에 필요한 값을 설정하는 부분
- **when** : 테스트 코드 실행, 예를 들어 메서드를 실행한다.
- **then** : 테스트에 기대되는 결과값을 단정하는 부분

<br>

테스트에 대한 결과값을 표현하기 위한 Assertion 은 다음과 같은 것들이 있다.

#### Boolean Assertion
true나 false 를 생성하는 조건을 테스트한다.
```swift
XCTAssertTrue(expression, message, file, line)
XCTAssertFasle(expression, message, file, line)
```
- expression : 테스트할 식
- message : 실패일 경우 출력할 메시지 (옵션)
- file : 실패가 발생하는 파일, 함수가 호출되는 테스트 케이스의 파일 이름 기본 값
- line : 실패가 발생하는 줄, 함수가 호출되는 줄이 기본 값

<br>  
  
#### Nil and Non-Nil Assertion
테스트 조건이 nil 인지 Non-nil 인지 테스트한다.
```swift
XCTAssertNil(expression, message, file, line)
XCTAssertNotNil(expression, message, file, line)
XCTUnwrap(expression, message, file, line)
```
- Unwrap : nil이 아닐 경우 나중에 사용할 수 있게 래핑되지 않은, 언래핑 된 값을 반환
- expression : 테스트할 식
- message : 실패일 경우 출력할 메시지 (옵션)
- file : 실패가 발생하는 파일, 함수가 호출되는 테스트 케이스의 파일 이름 기본 값
- line : 실패가 발생하는 줄, 함수가 호출되는 줄이 기본 값

<br>

#### Equality and Inequality Assertions
두 값이 같은지 다른지 테스트한다.

```swift
XCTAssertEqual(expression1, expression2, message, file, line)
XCTAssertNotEqual(expreesion1, expression2, message, file, line)
XCTAssertEqual(expression1, expression2, accuacy, message, file, line)
XCTAssertNotEqual(expression1, expression2, accuacy, message, file, line)
```
- expression1, expression2 : 비교할 수 있는 자료형의 식
- accuracy : expression1 == expression2 일 최대 차이 값 (Numeric, FloatingPoint 버전이 존재)
XCTAssertEqual 일 경우 expression1 == expression2이 accuracy값 내에서 같으면 true 반환
Floating-point 혹은 숫자형 자료형 값이 동일한지 판단하며, 두 숫자형 값이 오차범위를 벗어나면 테스트에 실패한다.

<br>  

#### Comparable Value Assertions
두 값을 비교해서 더 큰지 작은지를 테스트한다.

```swift
XCAssertGreaterThan(expression1, expression2, message, file, line)
XCAssertGreaterThanOrEqual(expression1, expression2, message, file, line)
XCAssertLessThanOrEqual(expression1, expression2, message, file, line)
XCAssertLessThan(expression1, expression2, message, file, line)
```
- GreaterThan : >
- GreaterThanOrEqual : >=
- LessThanOrEqual : <=
- LessThan : <

 <br>
 
#### Error Assertion
함수를 호출할 때 에러가 발생하는지 아닌지 확인하는 테스트

```swift
XCTAssertThrowsError(expression, message, file, line, errorhandler)
XCTAssertNoThrow(expression, message, file, line)
```
- ThrowsError : expression이 에러가 발생하면 true
- NoThrow : expression이 에러가 발생하지 않으면 true
- errorhandler : 식에서 에러가 발생할 경우 에러에 대한 핸들러

<br>

#### Unconditional Test Failures
무조건 바로 실패를 생성하는 테스트

```swift
XCTFail(message, file, line)
```
- expression : 에러가 발생 할 수 있는 식

<br>

#### Methods for Skipping Test
어떤 조건에 부합하면 테스트를 스킵

```swift
XCTSkipIf(expression, message, file, line)
XCTSkipUnless(expression, message, file, line)
```
- expression : Bool 값을 갖는 식


참고한 출처들
https://silver-g-0114.tistory.com/142
https://velog.io/@bibi6666667/TDD-%EB%8B%A8%EC%9C%84-%ED%85%8C%EC%8A%A4%ED%8A%B8-XCTest%EB%A1%9C-iOS-%EC%95%B1-%ED%85%8C%EC%8A%A4%ED%8A%B8%ED%95%98%EA%B8%B0
https://zeddios.tistory.com/1061
https://velog.io/@chagmn/Swift-XCTest-%ED%94%84%EB%A0%88%EC%9E%84%EC%9B%8C%ED%81%AC-Test-Assertion

<br>

### 🤟 세번째
> 유닛 테스트에 대해 알아보자


<br>
<hr>  

### 🌿 오늘의 민트 주간

#### 🌳 Xcode 시뮬레이터로 Remote Push Notification 테스트하기
출처 : https://swifty-cody.tistory.com/132

Xcode 11.4 부터 시뮬레이터로 Push Notification을 보낼 수 있다고 한다.
준비물은 다음과 같다.
- Xcode
- apns 파일
- Push Notification 코드

<br>
먼저 시뮬레이터에 Push를 보내기 위해선 세팅이 필요하다.
Xcode의 Target -> Signing & Capabilities 에서 Capabilities Push Notification을 추가한다.
기존의 Push Notification 연동하는 법과 같지만 나는 몰랐기 때문에 다시 한번 짚고 넘어가보려고 한다.

AppDelegate에서 **UserNotifications**를 import 한다.
didFinishLaunchingWithOptions 메소드에 다음과 같은 코드를 추가한다.

```swift
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
	print("Permission granted : \(granted)")
}
```
위 코드는 알림을 표시하기 위한 승인을 요청한다. 해당 코드를 추가하면 앱이 실행될 때 알림을 보낼 수 있는 권한을 요청하는 메세지가 뜨게 된다.

이때, 만약 사용자가 권한을 거부한다면? 그럴 때를 위한 코드도 추가해보자

```swift
UNUserNotificationCenter.current().getNotificationSettings { settings in
	print("Notification settings: \(settings)")
}
```

다음은 APN 서비스에 등록을 해야한다.

먼저 권한을 받아왔으니 받아온 권한이 authorized 인지 확인한다. 그리고 registerForRemoteNotifications() 를 이용해 푸시 알림 서비스에 등록을 시작한다.

```swift
guard settings.authorizationsStatus == .authorized  else { return }
DispatchQueue.main.async {
	UIApplication.shared.registerForRemoteNotifications()
}
```

그리고 토큰을 받아온다. AppDelegate 맨 마지막에 해당 코드를 추가한다.

```swift
func  application(_  application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken  deviceToken: Data) {
	let tokenParts = deviceToken.map { data in  String(format: "%02.2hhx", data) }
	let token = tokenParts.joined()
	print("Device Token : \(token)")
}
```

자 이제 사전 준비가 모두 끝났으니 진짜로 시뮬레이터에 푸시를 보내보자!
먼저 apns 파일이 필요하다.
파일 이름은 원하는대로 설정해도 되지만 여기서는 **payload.apns** 라고 설정하도록 하겠다.

payload.apns 안의 내용은 다음과 같다.
```
{
	"aps": {
		"alert": {
			"title": "시뮬레이터로 Push Notification 보내기",
			"body": "apns 파일로 간단하게"
		},
		"badge": 5
	},
}
```

막간의 팁으로 커맨드 라인에서 해당 파일을 만들고 저장하고 싶다면 내가 주로 이용하는 방법은
> vim payload.apns 를 입력해서 파일을 만들어 준 다음 위 코드를 입력한 후 esc + : + wq 를 눌러 저장하면 현재 위치에 payload.apns 파일이 생성된다.

이제 커맨드 라인을 킨다. 터미널 또는 iTerms 무엇이든 상관없다. payload.apns 가 있는 경로를 찾아가 다음과 같은 명령어를 입력한다.
``` 
xcrun simctl push (시뮬레이터 타겟) (시뮬레이터에 설치된 앱 BundleID) (apns 파일명)
```
현재 시뮬레이터 하나가 실행중일 때 아래처럼 booted를 타겟으로 커맨드를 입력한다.
```
xcrun simctl push booted com.personal.push-test payload.apns
```
이렇게 입력한 후 엔터를 눌러 실행을 하게 되면 다음과 같은 푸시가 시뮬레이터에 나타나게 된다!

<img  src="https://github.com/mingging/swiftui-daily-digest/blob/main/mindigo/SwfitUI%20fundametal%20Tutorial/assets/mint_4.png?raw=true" title=""></img><br/>

여기서 만약, 시뮬레이터가 2개 이상일 경우에는 해당 시뮬레이터 타겟을 정확히 명시해주어야 한다.
현재 실행중인 시뮬레이터 정보는 다음과 같은 명령어로 확인할 수 있다.
```
xcrun simctl list
```
```
== Devices ==
-- iOS 16.4 --
    iPhone 8 (DE9DE858-9771-4DF8-80BD-D91987804EF9) (Shutdown)
    iPhone X (4B6C9F76-4437-4616-8D9C-D0E6723B40C5) (Shutdown)
    iPhone SE (3rd generation) (87998F5A-DEEA-401B-BFFB-905CD79905B1) (Shutdown)
    iPhone 14 (F20B2B7F-DB00-494B-9F52-7F3AFB97B60B) (Shutdown)
    iPhone 14 Plus (9DC146DC-0AB4-4D11-BECC-464DC42FECC6) (Shutdown)
    iPhone 14 Pro (79AE8ACF-BE98-4773-B73B-64D88DC79A4A) (Booted)
    iPhone 14 Pro Max (CEA960F2-19B3-4A1E-ACF3-A4967E7708B0) (Shutdown)
    iPad Air (5th generation) (63E90729-784A-4EA5-85E8-0371B31B22D5) (Shutdown)
    iPad (10th generation) (231FBBCE-2B51-4DF0-BFA7-75105965AB64) (Shutdown)
    iPad mini (6th generation) (B6553862-05A2-41E2-859B-1DB2A25B5559) (Shutdown)
    iPad Pro (11-inch) (4th generation) (70ABB7C6-4564-461D-BFAC-88E01B6694AD) (Shutdown)
    iPad Pro (12.9-inch) (6th generation) (60275736-0344-4DCF-A326-9060414FC357) (Shutdown)
== Device Pairs ==
```
실행 중인 시뮬레이터 옆엔 (Booted) 라는 정보가 나온다. 저 디바이스의 아이디를 명시해주면 해당 디바이스에 푸시가 뜨게 된다.
```
scrun simctl push 79AE8ACF-BE98-4773-B73B-64D88DC79A4A com.personal.push-test payload.apns
```
<br>
이번에는 명령어를 조금 더 줄여보자.
아까 만들어둔 payload.apns 에 Simulator Target Bundle 를 이용해 BundleID를 명시해주면 

```
{
	"aps": {
		"alert": {
			"title": "시뮬레이터로 Push Notification 보내기",
			"body": "apns 파일로 간단하게"
		},
		"badge": 5
	},
	"Simulator Target Bundle": "com.personal.push-test"
}
```
BundleID를 명령어에 입력하지 않아도 푸시가 오게 된다.
```
xcrun simctl push booted payload.apns
```
마지막으로 가장 간단하게 payload.apns 파일을 시뮬레이터에 드래그 앤 드롭으로 넣어도 푸시가 온다.
이때는 apns 파일에 Simulator Target Bundle 이 추가되어 있어야한다.