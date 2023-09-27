# ForEach로 뷰 여러개 그려보기

```swift
struct Fruit: Hashable {
    let name: String
    let count: Int
}

extension Fruit {
    static var lists: [Fruit] = [
        Fruit(name: "apple", count: 100),
        Fruit(name: "banana", count: 50),
        Fruit(name: "melon", count: 1),
        Fruit(name: "mandarin", count: 2),
    ]
}

struct ForEachTestView: View {
    let fruits = Fruit.lists
    
    var body: some View {
        VStack {
            ForEach(fruits, id: \.self) { fruit in
                Text(fruit.name) + Text("\(fruit.count)개 있음")
            }
        }
    }
}
```


- index로도 넘길 수 있다는 거 기억

___

## 정돈된 내용


```swift
struct ForEachBootcamp: View {
    
    private struct NamedFont: Identifiable {
        let name: String
        let font: Font
        var id: String { name }
    }

    private let namedFonts: [NamedFont] = [
        NamedFont(name: "Large Title", font: .largeTitle),
        NamedFont(name: "Title", font: .title),
        NamedFont(name: "Headline", font: .headline),
        NamedFont(name: "Body", font: .body),
        NamedFont(name: "Caption", font: .caption)
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(namedFonts) { namedFont in
                Text(namedFont.name)
                    .font(namedFont.font)
            }
        }
    }    
}
```

ForEach의 ()안에 들어오는 데이터는 Identifiable 해야함  
지금 같은 경우에는 computed property로 id를 name으로 지정해줬음  

___

```swift
struct ForEachBootcamp: View {
    var body: some View {
        VStack {
            Text("One")
            Text("Two")
            Text("Three")
        }
    }
}
```
이런 코드가 있다고 했을 때 Text를 더 많이 늘리고 싶을 수 있잖음

![](https://velog.velcdn.com/images/woojusm/post/5b311175-dd36-45d2-9aba-d9eec5b34ec6/image.png)

ForEach를 넣어주는 거임  

![](https://velog.velcdn.com/images/woojusm/post/a19ad2fb-9128-4b4a-96fa-dbecb05534cf/image.png)

![](https://velog.velcdn.com/images/woojusm/post/368f2fa8-0d5b-48c5-82f5-e659bb05840a/image.png)

![](https://velog.velcdn.com/images/woojusm/post/cb109879-7ed5-4cd7-92a8-528dc32efc32/image.png)

ForEach 뒤에는 루프할 대상이 오고, 클로져 내에선 루프하는 대상 각각에 대한 처리를 해줄 수 있음  
![](https://velog.velcdn.com/images/woojusm/post/bca107b4-2e1a-408a-95b8-3ff8ab7862a2/image.png)

이렇게만 했을 땐 Non-constant range 경고가 나온다  
지금 선언해줬던 Array가 identifiable하지 않아서 그럼!  
현재의 상태에서 Array data의 element값이 같을 경우에는 에러가 발생할 수 있음    
그래서 경고를 해주는거!
