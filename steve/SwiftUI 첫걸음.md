# SwiftUI 첫걸음

현재 어느 정도 SwiftUI에 대해서 숙지하고 있는 상태라 정해진 강의 분량은 시간날 때 한번에 몰아서 학습한 후에 따로 정리하겠습니다!  
일전에도 말씀 드렸던 것처럼 WWDC로 학습을 하는 것이 장기적으로 되게 좋다고 생각이 들어서  
영어가 친숙하지 않은 분들께도 도움이 되었으면 좋겠네요:)  

## [Introducing SwiftUI: Building Your First App](https://developer.apple.com/wwdc19/204)
<img width="1392" alt="스크린샷 2023-09-07 오후 9 23 04" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/11d1eba5-9477-4e09-b12a-21c452fdd5f6">

여기서 마우스 머튼 모양 클릭하면 View들 Click 가능해지죠  
Command Shift L로 라이브러리 열고 드래그앤 드롭으로 View 넣는 것도 가능함   

<img width="1154" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/2902e1fd-a099-47a2-b3c3-72401ca2fe81">

내가 스토리보드처럼 써보고 싶다! 우측 인스펙터 패널 열면 됩니다~  

___

### The Way Views Work
SwiftUI에서 View는 View Protocol을 채택하는 구조체임 (base class로부터 상속받는 UIView랑은 다르죠?)  
그러니까 View는 어떤 stored property도 inherit하지 않는다는 걸 의미하기도 하죠  
stack 영역에 할당 되고 value로 전달 됩니당  
내부적으로는  
<img width="1139" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/a35f8ec0-5d5e-4c9a-8194-655494a54fd9">
SwiftUI는 우리 뷰 계층을 효율적인 데이터 구조만 가지고 aggressively collapses 하면서 렌더링 합니다.  
움... 번역을 뭐라고 해야할지 모르겠는데 그냥 엄~청 자주자주 만들고 뿌신다!  

> 참. 한 가지 종종 도움 되는 트릭인데  
> body 내에서 print문 찍고 싶을 경우에  
> `let _ = print("찍어찍어!") 작성하면 body내에서 다이렉트로 프린트문 찍어볼 수 있습니다!  
> <img width="1009" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/419aeae1-7027-47a1-be3c-5901a60b2cce">  
> 시뮬레이터에선 한번 찍히지만 캔버스에선 엄청 많이 찍히는 프린트문! (진짜 생각보다 엄청 자주자주 만들어지는 걸까요?!)  

스유 뷰는 진~짜 가벼워요 그니까 View를 SubView로 리팩토링 하는 거 고민 노노!  
서브 뷰 빼서 뷰를 그리더라도 runtime 오버헤드는 아예 없다고 봐도 무방합니다.  

그래서그래서 View는 UI의 한 부분을 정의 하는거죠!!  

```swift
import SwiftUI

struct RoomDetail: View {
    let room: Room
    
    var body: some View {
        Image(systemName: room.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
    }
}

struct RoomDetail_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetail(room: Room())
    }
}

struct Room {
    let imageName: String = "applelogo"
}
```

View 프로토콜은 프로퍼티 하나만 요구해용.  
바로바로 body 프로퍼티 입니다. (body 프로퍼티는 그 자체로 View에요)  

어떤 View든지 작성하게 되는 건 사실 이 View의 body안에 있는 View를 렌더링한다는 거에요  
저 이미지 라인에서 Break Point 걸면 어떻게 될까요!  
(WWDC에선 그래도 바로 View가 렌더링 된다고 설명하는데 안되네요)  

### View Defines its Dependencies.
> 스유에서 View는 이놈 자체가 Dependencies를 정의합니다.

스유의 View에서도 프로퍼티가 필요하겠죠  
@State로 선언된 프로퍼티가 있으면 어떤 일이 생길까요!  

<img width="1135" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/47cc2646-b8bd-4739-a029-562a7f725fa6">
메모리 다이어그램으로 한번 볼게요  
뷰 뒷단으로 해당 프로퍼티가 할당이 되게 됩니다.(보라색 SwiftUI가 관리함)   
  
     
  
<img width="404" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/180620d8-14d6-4ee2-8289-1e99f7fc1716">  
  
<img width="486" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/0fe1dcec-f7cc-45a6-bf71-655c7cda6c63">  

___

여기서 부턴 설명이 좀 필요해서  
키워드 작성해두고 다음 스터디 때 얘기해볼게용~   

```swift
struct RoomDetail: View {
    let room = Room()
    
    @State private var zoomed = false
    
    var body: some View {
        Image(systemName: room.imageName)
            .resizable()
            .aspectRatio(contentMode: zoomed ? .fill : .fit)
            .onTapGesture {	            
                zoomed.toggle()
            }
    }
}
```

- withAnimation vs .animation()

- .scaledToFill()

- Button vs onTapGesture 차이
뭔가 Button이 필요하다! -> 그냥 버튼 쓰세요
(버튼 클릭되는 애니메이션이 맘에 안든다 ButtonStyle 적용해서 온갖 애니메이션으로 커스텀 가능합니다)

그럼 어떤 때에 onTapGesture? 탭의 횟수를 지정하고 싶고, 탭 이벤트를 뷰의 특정한 좌표로 내가 지정하고 싶다! -> onTapGesture  
LinkedIn에서 아티클 읽었던 건데 Button이 대부분 퍼포먼스에 있어서 이점이 있다고 읽게 됐어요. 자세한 건 실험해봐야 알겠지만  
아 이런 이슈가 있을 수도 있구나 ~ 미리 생각해두면 좋겠죠!  

아무튼!  
State로 프로퍼티를 선언하면 SwiftUI가 알아서 읽어야 되는 타이밍 / 써야 되는 타이밍을 재고 있어요  
State로 감싸진 우리의 프로퍼티의 값이 바뀐다 -> 상태값이 바뀐다!  
프레임워크는 body 한테 다시 물어보게 됩니다. 그래서 refresh가 되고, 렌더링까지 이뤄지게 되는겁니다~!  

### Where Is Truth?

<img width="1093" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/08bc10dd-8540-4bad-8d31-0111b5e022e0">  
방금 썼던 .aspectRatio도 사실은 View로 표현 가능하구  

<img width="708" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/db0d809f-04c8-4705-acd3-8a21c8efd13e">

[Data Flow Through SwiftUI](https://developer.apple.com/wwdc19/226)  
요기 내용이랑 밀접하게 연관이 있어서 우선은 넘어갈게용  

### Managing Dependencies is Hard

예전으로 돌아가보자구요
UIView 가 data를 읽게 된다 -> 이 자체로 dependency가 생기는 거임  
<img width="988" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/08658f66-49d9-43de-909e-028386ebfafd">

데이터가 바뀐다? UIView도 업뎃 해줘야 하쥬  
<img width="1009" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/8c53794e-b2ff-4b29-979b-042f94d054e1">


근데 업뎃 실패하면?  
<img width="1103" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/15a4a1e0-570d-4ab3-9a76-ae2d65fdadd5">  
버그 발생 ㅋㅋ..  

<img width="1130" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/28db5aa4-a562-4e50-b5ca-7ee3e1ef9640">  

워우... 서로가 엄청 얽히고 섥혀 있죠  

<img width="804" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/3473fd8e-5a6f-4729-96cc-882fb389ae66">

UIKit 예시인데
이미지가 있었다 -> 확대했다 -> blurry해서 머신 러닝으로 깨끗하게 만들어줘야했다 -> 그동안 인디케이터 표시했다  

> 근데 갑자기 유저가 축소를 해버린겨  
> 인디케이터가 안사라져 버륌..

<img width="702" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/1a9b5c5c-0a72-4f98-8a15-1905f8e69cdb">  

우리가 생각해야 하는 어떤 로직이 실행될 수 있는 경우의 수가 늘어날수록 버그는 더 많아질거임

요런 거 한 메소드로 묶어서 하시고 있죠! 복잡성을 줄이는 이 방법 존중합니다!
SwiftUI도 여기서 많이 배웠어요

# 우리가 생각하면 되는 거

<img width="785" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/22e04856-5660-4277-a5f6-948348c8bef3">

body body body body body body  
body body body body body body 

바디만 신경쓰소!  
<img width="1139" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/3f7919fb-74f7-4d5e-b3c5-ebd705b2e8a5">  

데이터 변하는 거 감지하고 렌더링까지! 그거 우리 SwiftUI가 알아서 해줄게!

___

이 다음엔 reference 타입의 프로퍼티 래퍼와 프로토콜을 소개 합니다  

<img width="1137" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/51a31f1c-8838-45b9-9393-bd5ca94bc325">

현재의 표현은 Combine에서 왔다고 소개합니다.  
와 ㅋㅋㅋ 예전엔 이랬었네요  

지금은 그냥 ObservabaleObject 쓰면 됨!  
그리고 알 수 있는 거!! ObservableObject는 Combine에서 시작했구나!!  

___

그리고 설명하는 내용은   
부족한게 있다면  
@Environment 프로퍼티 써라~
우리가 셋업 다 해놨다~
다이나믹 타입, 다크모드, 로컬라이제이션
.environment()로 View에 달아주면 됨  

___

여기까지가 세션 내용이구

추가로 설명하고 싶은 건  

@State는 value 타입에만 가능하다...?

[What is the @State property wrapper? - a free SwiftUI by Example tutorial (hackingwithswift.com)](https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-state-property-wrapper#:~:text=SwiftUI%20uses%20the%20%40State%20property%20wrapper%20to%20allow,struct%20and%20into%20shared%20storage%20managed%20by%20SwiftUI.)

reference 타입에도 @State 쓸 수 있긴함. 다만 변경사항을 우리의 뷰가 알 수는 없음

특히 ObservableObject 프로토콜 채택하지 않는 class에서 사용할 수 있다네요 (이렇게 쓸일 없음 ㅎㅎ..)
```swift
class PostModel {
    var title: String = "제목 입니다"    
}

struct PostView: View {
    @State private var post = PostModel()
    
    var body: some View {
        Text(post.title)
            .onTapGesture {
                post.title = "터치 되었습니다"
                print(post.title)
            }
    }
}
```
___

# 근데 iOS 17에서...
@Observable **매크로**가 나왔어요 

또 바꼈어~!~! 라고 생각할 수 있는데  

<img width="1152" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/cae8f216-d133-4e47-a988-b8610a312c01">  

@Observable 붙인 애들은 따로 상태 값 관리하는 프로퍼티 래퍼 없이도
View가 관측을 함

Swift Data 때문에 이렇게 바뀐 것 같기도... DB좀 쉽게 구성할라고 그른가  

<img width="722" alt="image" src="https://github.com/woozoobro/swiftui-daily-digest/assets/99154211/48c58abc-7eed-4619-a09c-03f369c8e8ac">  

17에서 부터 요런 macro가 생겼다는 거 알아두기!  

___

## State랑 Binding 실습

[요거 한번 만들어보면 바로 감을 잡지 않을까 싶습니다!](https://www.youtube.com/watch?v=4s4QAyiYWwc)  



