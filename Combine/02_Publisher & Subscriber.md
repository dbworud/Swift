## Publisher 종류

### 1. Convenience Publisher
* Just: 가장 단순. 에러 타입으로 Never반환
* Promise: Just와 비슷하지마 Filter Type 정의할 수 있음
* Fail: 정의된 실패타입 발행
* Empty: 어떤 데이터도 발행하지 않음. 주로 에러처리나 옵셔널값을 처리할 때 사용
* Sequence: (1...10).publisher같이 데이터를 순차적으로 발행. 
* ObservableObjectPublisher: ObservalbeObject를 준수하는 Publisher

### 2. Published Annotation
PropertyWrapper를 통해 사용할 수 있음
```swift
@Publised var userName: String = ""
```

### 3. Subject
* Publisher의 일종 
* **파이프라인 외부에서도 내부로 데이터를 보낼 수 있음** 때문에, 기존 combine프로토콜이 아닌 콜백클로저로 구현되어있더라도
subject를 이용하면 쉽게 리팩토링할 수 있음
* 또한, 다른 Framework와 쉽게 연동하여 사용할 수 있음

#### PassthroughSubject
상태값을 가지지않는 subject로서, 콜백클로저로 구현되어있더라도 쉽게 리팩토링 가능
```swift
let subject = PassthroughSubject<String, Error>()

subject.sink(receiveCompletion: { completion in
// 에러가 발생하 경우에도 receiveCompletion이 호출됨
  switch completion {
    case .failure: 
      print("Error가 발생하였습니다")
    case .finished:
      print("데이터 발행이 끝났습니다")
    }
  }, receiveValue: {value in
    print(value)  
  })
  
// 데이터를 외부에서 발행할 수 있다
subject.send("A")
subject.send("B")
// 데이터 발행을 종료한다
subject.send(completion: .finished)
```

#### CurrentValueSubject
상태값을 가지는 subject로서, 주로 UI상태값에 따라 데이터를 발행할 때 유용



## Subscriber 종류
* Subscriber를 상속받아 직접 구현하기
* sink를 이용하여 결과값 받기
* assign을 이용하여 스트림 값 전달하기

### Subscriber를 상속받아 직접 구현하기
모든 라이프사이클 확인 가능

```swift
class CustomSubscriber: Subscriber {
  func receive(completion: Subscribers.Completion<Never>){
    print("모든 데이터가 발행되었습니다")
  }
  
  func receive(subscription: Subscription){
    print("데이터의 구독을 시작합니다")
    subscription.request(.unlimited) // 구독할 데이터의 개수를 제한하지 않음
    // subscription.request(.max(2)) 개수를 2개로 제한
  }
  
  // 구독 이후 데이터 스트림으 변경할 때 사용
  func receive(_ input: String) -> Subscribers.demand {
    print("데이터를 받았습니다", input)
    return .none
    // return .unlimited 이전의 설정을 무시하고 모두 구독
  }
  
  typealias Input = String // 성공타입
  typealias Failure = Never // 실패타입

}

let publisher = ["A", "B", "C", "D", "E", "F", "G"].publisher
let subscriber = CustomSubscriber()
publisher.subscribe(subscriber)

```
