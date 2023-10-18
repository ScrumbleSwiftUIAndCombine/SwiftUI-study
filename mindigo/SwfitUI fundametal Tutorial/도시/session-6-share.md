## #24

minimumScaleFactor : 텍스트가 길어지면 자동으로 작아진다.

? : API 통신할 때 라이브러리를 무엇을 쓰는지?

? : CodingKey 가 뭘까?

DataModel에 Identifiable 을 이용해 고유한 아이디를 준다.

ObservableObject 를 이용해 ViewModel을 만들어 API를 호출한다.

Combine 개념 잡기 -> 찾아보기

Combine에서 Optional 제거하기
-> compactMap : 값이 있는 것만 가져오기 때문에 Unwrapping이 자동으로 된다.
-> map : results 만 가져오도록 할 수 있음 (대신 순서대로 써야함)

dummyData 만들기
```swift
static func getDummy() -> Self {
	return RandomUser(name: Name(), photo: Photo())	
}
```

CustomStringConvertible

## #25
##### RefreshControl

SwiftUI에서는 RefreshControler를 지원하지 않는다. -> UIKit을 이용해야한다. -> 근데 지금은 있음
RefreshControl
Introstect (https://github.com/siteline/swiftui-introspect)
```swift
let refreshControlHelper = RefreshControlHelper()

List
.introspectTableView { tableView in 
	// tableView.refreshControl = UIRefreshControl()
	let myRefresh = UIRefreshControl()
	refreshControlHelper.refreshControl = myRefresh
	refreshControlHepler.parentContentView = self

	myRefresh.addTarget(refreshControlHelper, action: #selector(RefreshControlHelper.didRefresh), for: .valueChanged)
}
```

RefreshControl 에 액션 달기 
UIKit으로 RefreshControl 을 만들어서 액션 붙여주기
```swift
class RefreshControlHelper {
	var parentContentView: ContentView?
	var refreshControl: UIRefreshControl?

	@objc func didRefresh() {
		print(#fileID, #function, #line, " ")
		guard let parentContentView = parentContentView,
			let refreshControl = refreshControl else {
			print("parentContentView, refreshControl")
			return
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
			refreshControl.endRefreshing()
		}
	}
}
```

iOS 15부터는 SwiftUI List 에 refresh modifier가 추가됨
https://www.hackingwithswift.com/quick-start/swiftui/how-to-enable-pull-to-refresh

```swift
.refreshabel {
	pritn("Pull")		  
}
```

Combine으로 액션을 보내서 viewModel 쪽에서 이벤트 처리하기
```swift
var refreshActionSubject = PassthroughSubject<(), Never>()

init() {
	// 외부에서는 fileprivate인 fetchRandomUsers 에 접근을 하지 못하지만 refreshActionSubject를 이용해 api 통신이 가능하다
	refreshActionSubject.init { [weak self] _ in 
		guard let self = self else { return }
		self.fetchRandomUsers()
	}.store(in: &subscription)
}
```

```swift
parentContentView.randomUserViewModel.refreshActionSubject.send()
```


## #26
##### 무한 스크롤 페이징 처리

Router 만들기
RandomUserRouter.swift
Alamofire RoutingRequest

```swift
let BASE_URL = ""

enum RandomUseRouter: URLRequestConvertible {
	case getUsers(page: Int = 1, result: Int = 20)

	var baseURL: URL {
		return URL(string: BASE_URL)!
	}

	var endPoint: String {
		switch self {
		case .getUsers:
			return ""
		default: 
			return ""	
		}
	}

	var method: HTTPMethod {
		switch self {
		case .getUsers: return .get
		default: return .get
		}
	}

	var paramters: Paramters {
		switch self {
		case let .getUsers(page, results):
			var params = Paramters()
			params["page"] = page
			params["results"] = results
			params["seed"] = ""
			return params
		}
	}

	func asURLRequest() throws -> URLRequest {
		let url = baseURL.appendingPathCompnent(endPoint)
		var request = URLReqeuslt(url: url)
		request.method = method
		
		switch self {
		case .getUesrs:
			request = try URLEncoding.default.encode(request, with: parameters)
		}

		return request
	}
}
```

느낌이 Moya를 보는 기분인것 같다. 아닌가?

ViewModel에서 RandomRouter 를 호출한다.
RandomUserRouter.getUsers 호출

무한 스크롤을 위해 추가로 page를 가져올 수 있는 메서드 추가
```swift
fileprivate func fetchMore() {
	guard let currentPage = pageInfo.page else {
		print("페이지 정보가 없음")
		return
	}

	// 현재 데이터를 가져오고 있으면 가져오지 않도록 플래그 설정
	self.isLoading = true

	let pageToLoad = currentPage + 1

	AF.reqeust(RandomUserRouter.getUsers(page: pageToLoad))
		.publishDecodable(type: RandomUserResponse.self)
		.compactMap { $0.value }
		.sink(receiveCompletion: { completion in 
			print("")
			self.isLoading = false
		}, receiveValue: { receiveValue in 
			// 배열에 추가적으로 가져온 데이터 추가
			self.randomUsers += receiveValue.result
			self.pageInfo = recivedValue.info
		}).stroe(in: &subscription)
}
```

PassthroughSubject를 이용해 fetchMore 를 가져온다.
```swift
var fetchMoreActionSubject = PassthroughSubject<(), Never>()
```

? : PassthroughSubject는 무엇일까?

리스트의 스크롤이 끝일 때 새로운 데이터를 가져온다.
리스트의 끝을 알 수 있는 방법 = RandomUser 끼리 비교를 하면 된다.
```swift
// Equtable = 같은 지의 여부를 판단한다. (protocol)
// lhs의 userId와 rhs의 userId가 같으면 true
extension RandomUser: Equtable {
	static func == (lhs: RandomUser, rhs: RandomUser) -> Bool {
		return lhs.id == rhs.id
	}
}
```

RandomUserRowView가 생성이 될 때 (onAppear) id 값을 비교해서 마지막이면 새로운 데이터를 가져온다.
```swift
RandomUserRowView(aRandomUser)
	.onAppear {
		if self.randomuserViewModel.randomUsers.last == aRandomUser {
			randomUserViewModel.fetchMoreActionSubject.send()
		}
	}
```

데이터를 가져오고 있을 때 progress를 띄우기
```swift
if randomUserViewModel.isLoading {
	ProgressView()
		.progressViewStyle(
			CircleProgressViewStyle(tinit: Color.yellow)
		)
		.scaleEffect(1.7, anchor: .center)
}
```


## #27
##### 뷰 모디파이어

```swift
// 뷰를 꾸며주는 모디파이어
struct MyRoundedText: ViewModifier {
	// 현재 컨텐츠를 가져와서 모디파이어를 적용하고 return 한다.
	func body(content: Content) -> some View {
		content
			.font(.largeTitle)
			.padding()
			.background(.yellow)
			...
	}
}
```

적용시키는 방법은 다음과 같다.
```swift
Text("")
	.modifier(MyRoundedText())
```

더 간결하게 하는 방법도 있다.
모두 뷰이기 때문에 뷰에 대한 익스텐션을 만든다.

```swift
extension View {
	func myRoundedTextStyle() -> some View {
		modifier(MyRoundedText())
	}
}

Text("")
	.myRoundedTextStyle()
```


## #28
##### 다크모드

```swift
struct Theme {
	static func myBackgroundColor(forScheme scheme: ColorScheme) -> Color {
		let lightColor = Color.white
		let darkColor = Color.black

		// 다크모드냐 라이트모드냐에 따른 분기점 처리
		switch scheme {
		case .light: return lightColor
		case .dark: return darkColor
		@unknown default: return lightColor
		}
	}
}
```

Environment를 이용해 받을 수 있다.
PropertyWrapper
```swift
@Environment(\.colorScheme) var scheme
```
색이 변경되었을 때 (다크모드 또는 라이트 모드 일 때) scheme의 값이 변경된다.

```swift
Theme.myBackgroundColor(forScheme: scheme)
```

버튼 색상도 동일한 방법으로 변경할 수 있다.
적용할 땐 다음과 같이 한다.
```swift
Text("")
	.background(Theme.myButtonBackgroundColor(forScheme: scheme))
```


## #29
##### 화면 녹화 방지

NotificationCenter -> onReceive를 이용해 받을 수 있다.
UIScreen.captureDidChangeNotification


## #30
##### State, Binding, EnvironmentObject

State
- 값이 변경되었을 때 화면에 보여줘야 할 때

Binding
- state 같은 것들을 화면간에 공유해야 할 때 좁은 영역

EnvironmentObject
- 하위 뷰에 모두 공유해야 할 때
###### State

```swift
@State var count = 0
```

```swift
VStack {
	Text("count : \(count)")
		.padding()
	
	Button {
		count = count + 1
	}, label: {
		Text("카운트 업")
	}
}
```

버튼을 누르면 화면에 변화가 된다. 값이 변경 됐을 때 뷰를 다시 그린다.

일반 property 를 변경하려고 하면 변경이 되지 않는다. State를 사용해야 한다.
-> 변수가 변경이 된다고 해서 뷰가 새로 그려지지 않는다.

초기화를 통해서 값을 전달받는 방법으로도 사용할 수 있다.
-> 외부에서 생성될 때 넘겨준다.

###### Binding

```swift
@Binding var count: Int
```
뷰 간의 상태를 공유할 필요가 있는 경우 서로 묶는다.

$(달러사인)을 이용해 값을 전달한다.
```swift
BeforeBadView(count: $count)
```
뷰 간의 State 상태 값을 공유한다.

생성할 때 생성자로 넣어줄 수 있다. 
Binding 값이 안들어왔을 때 값을 지정해줄 수 있다.
-> 대신 값의 변화는 없다.
```swift
init(count: Binding<Int> = .constant(99)) {
	_count = count
}
```

###### EnvironmentObject

```swift
class MyViewModel: ObservableObject {
	@Published var appTitle: String = "일상"
}
```

SceneDelegate에서 ContentView가 생성될 때 MyViewModel을 넘겨준다.
```swift
ContentView()
	.environmentObject(MyViewModel())
```

```swift
@EnvironmentObject var viewModel: MyViewModel
```
ContentView 를 처음 만들 때 MyViewModel을 넣어주고 하위 뷰에 전부 적용하도록 한다.
부모에게 제공받은 것을 사용한다. -> 처음 ContentView에 environmentObject로 설정해준 ViewModel

Publisher 로 들어온 값을 처리하는 onReceive
감지할 때는 달러사인을 이용한다.
```swift
.onReceive(viewModel.$appTitle) { recievedAppTitle in 
	appTitle = receviedAppTitle
}
```
