### #33

<aside>
💡 웹뷰 전화, 이메일, 특정 사이트 막기

</aside>

```swift
// 외부로 링크 열기
UIApplication.shared.open(url, options: [:], completionHandler: nil)
decisionHandler(.cancel)
```

- 특정한 도메인일 때 이동하지 못하게 하기

```swift
decisionHandler(.cancel)
```

### #35

<aside>
💡 최상단 뷰컨 가져오기

</aside>

[UIkit 에서 재귀함수를 활용한 최상단 뷰컨트롤러 가져오기 입니다!](https://gist.github.com/TuenTuenna/696cc8e0966eb2be64cac340aaea8904)

### #36

<aside>
💡 탭 제스처

</aside>

```swift
.gesture // 를 이용해서 제스쳐 추가
```

```swift
var tap: some Gesture {
	TapGesture(count: 3) // count를 이용해 몇번 탭할 시 실행하는지 정할 수 있음
		.onEnded { _ in 
			print("3번 탭")
		}
}
```

### #38

<aside>
💡 ScrollView Reader

</aside>

```swift
// 프로그래밍으로 스크롤뷰를 스크롤 해야할 때 사용
ScrollViewReader { proxy in
	// 위치는 상관이 없음 ScrollView 안에 또는 밖에 사용
}
```

- `proxy.scrollTo` 를 이용해 스크롤을 할 수 있음
- id : 뷰가 어디있는지 알기 위해 고유한 id를 설정

### #39

<aside>
💡 드래그 앤 드랍

</aside>

- DropDelegate 를 이용해 드래그 앤 드랍을 만들 수 있음

### #40

<aside>
💡 운영 & 개발 나누기

</aside>

1. Targets → BuildSetting (asset 검색) → Primary App Icon Set Name (Debug, Release 세팅)
2. Targets → BuildSetting (packaging 검색) → Packaging → Product Bundle Identifier (Debug, Release 세팅)
3. Targets → BuildSetting (위에 + 버튼 클릭)
4. User-Defined → BUNDLE_ID_SUFFIX 만들기 (Debug, Release 세팅)
5. Targets → BuildSetting(bundle display name 검색) (Debug, Release 세팅)

### #41

<aside>
💡 ColorLiteral

</aside>

```swift
Color(#colorLiteral())
```

- 뷰 안에서 적용은 안된다. 변수 선언시에는 가능하다

### #42

<aside>
💡 FCM 푸시 운영 / 개발

</aside>

- 애플 개발자 계정이 필요하다

방식 2가지

- p12 기존 방식 - 1년 마다 갱신해야 함 - 키 발행 수 제한 X
- p8 새로운 방식 - 갱신 안해도 된다. (보다 간편) - 키 발행 수 제한 1인 2개 최대
- Capabillity 추가 (Push Notification)
- UNUserNotificationCenterDelegate 이용
    - 푸시 메세지가 앱이 켜져 있을 때 호출됨
        
        ```swift
        func userNotificationCenter(_ center: UNUserNotifiactionCenter, willPresent notification: UNNotification ...)
        ```
        
    - 푸시 메세지를 받았을 때
        
        ```swift
        func application(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse ...)
        ```
        
    - fcm 토큰이 등록 되었을 때
        
        ```swift
        func application(_ application: UIApplication, didRegisterForRemoteNotificationWithDeviceToken deviceToken: Data)
        ```
        
- MessagingDelegate 이용
    - fcm 등록 토큰을 받았을 때
        
        ```swift
        func massaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {}
        ```
        
- 개발 / 운영 나눌 경우
    - Target → Build Phase → 추가 → New Run Script Phase 생성
    - 나눠진 firebase info plist 빌드 타입에 따른 설정
    
    ```bash
    #파이어베이스 인포 리스트 올리기 개발, 운영
    PATH_TO_GOOGLE_PLISTS = "${PROJECT_DIR}/${PRODUCT_NAME}/Firebase"
    
    case "${CONFIGURATION}" in "Debug" )
    cp -r "$SRCROOT/${PRODUCT_NAME}/Firebase/GoogleService-Info-Dev.plist"
    			"${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info" ;; "Release" )
    cp - r "$SRCROOT/${PRODUCT_NAME}/Firebase/GoogleService-Info-Prod.plist"
    			"${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
    *)
    ;;
    esac
    ```
    

### #민트주간

출처 : [https://medium.com/sling-inc/비정기-태블릿-챕터-gitmoji-빠르고-명확한-소통의-시발점-6e57b3189501](https://medium.com/sling-inc/%EB%B9%84%EC%A0%95%EA%B8%B0-%ED%83%9C%EB%B8%94%EB%A6%BF-%EC%B1%95%ED%84%B0-gitmoji-%EB%B9%A0%EB%A5%B4%EA%B3%A0-%EB%AA%85%ED%99%95%ED%95%9C-%EC%86%8C%ED%86%B5%EC%9D%98-%EC%8B%9C%EB%B0%9C%EC%A0%90-6e57b3189501)

**`Gitmoji`**

- git + emoji를 합친 단어로, 모든 커밋 메세지 앞에 이모지를 붙이는 행위이다.
- 더 나은 커밋 메세지를 쓰는 방법 중 하나이다.
- 커밋은 “내가 무슨 일을 했는지 동료에게 보여줄 수 있는 방식” → 깃모지는 더 좋은 커밋을 만들기 위한 **`Syntactic Sugar(문법적 설탕)`** 이다.
    - :: Syntactic Sugar : 문법적 기능은 그대로인데 그것을 읽는 사람이 직관적으로 쉽게 코드를 읽을 수 있게 만든다.

**특징**

[장점]

- 브랜치에서 무슨 작업을 헀는지 시각적으로 확인이 가능하다.
- [블로그 이미지 발췌]
    
    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/5dff3da6-b0a1-4e55-9426-04c8bba655bd/191b1e6c-1366-447f-b8fb-f2d6a805138f/Untitled.png)
    
    - 위에서 사용된 이모지의 의미는 다음과 같다.
        - 🔖 : 버전을 올릴 경우
        - 🐛 : 버그 픽스
        - 💄 : 레이아웃 수정
- 더 빠른 PR 리뷰가 가능하다
    - 이모지에 따라서 이미 기능에 대한 설명이 되어있으니 커밋별로 설명이 들어간다면 명확하게 이해가 빨라질 수 있다.
- 일정 산정 능력을 키울 수 있다.
    - 커밋 단위로 생각하면 일정 산정 능력에 도움이 된다.
- 개발에만 집중할 수 있는 시간이 늘어난다.

[단점]

- 익숙하지 않으면 쓰기가 어렵다.
    - 공식적으로 어떤 이모지를 어떨 때 사용하는지에 대한 사이트가 있다.
        
        [gitmoji](https://gitmoji.dev/)