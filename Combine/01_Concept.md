## Combine?
* 시간의 흐름에 따라 발생하는 이벤트를 처리하는 API, 발생한 이벤트를 어떻게 가공하고 소비할 것인지?
* 선언형 프레임워크, 함수형 프로그래밍, 비동기 처리
* Essential Framework that empowers SwiftUI

## 구성요소 

<img width="674" alt="image" src="https://user-images.githubusercontent.com/59492694/87907958-93b65680-caa0-11ea-8174-15cd4c53afa6.png">

<img width="594" alt="image" src="https://user-images.githubusercontent.com/59492694/87908038-be081400-caa0-11ea-8813-b520e0ce2a59.png">

* **Publisher**: Error가 발생했을 경우, Failure타입 전달. 그렇지 않으면 Output타입 전달
* **Subscriber**: Publisher의 Output = Subscriber의 Input, Publisher의 Failire = Subscriber의 Failure 타입을 가져야 함

## Publisher
```swift
protocol Publisher {
  associatedtype Output
  associatedtype Failure : Error
  func receive<S>(subscriber : S) where S : Subscriber, self.Failure = S.Failure, Self.Output = S.Input
}
```
* Publisher 중에서 ConnectablePublisher 프로토콜을 준수하는 Publisher는 autoconnect를 이용하여
subscriber 연결여부와 상관없이 미리 데이터 발행시킬 수 있음

## Subscriber
```swift
protocol Subscriber {
  associatedtype Input
  associatedtype Failiure : Error
  
  func receive(subscription: Subscription)
  func receive(_ input: Self.Input) -> Subscribers.Demand
  func receive(completion: Subscribers.Completion<Self.Failure>)
}
```
* Publisher -> Subscriber로 데이터를 전달하느 과정을 '파이프라인'
* 파이프라인에서는 꼭 성공 타입과 실패 타입을 명시해주어야 함
* 생성자와 소비자의 타입이 일치하지 않으면 에러 발생

## 예제

```swift
Just(5).sink {
  print($0)
} // 5 
```
* Just는 오직 하나의 값만 출력
* 실패타입은 항상 Never로 리턴
* sink는 클로저 형태로 데이터 값을 받는 Subscriber로, 실패타입은 Never로 받음

```swift
let provier = (1...10).publisher // sink 전까지 데이터를 발행하지 않음

provider.sink(receiveCompletion: {_ in
  print("데이터 전달이 끝났습니다.")
}, receiveValue: { data in
  print(data)
})
```
* 데이터 스트림 발행
* sink로 연결될 때 구독(subscribe)이 시작

<img width="591" alt="image" src="https://user-images.githubusercontent.com/59492694/87910000-3c19ea00-caa4-11ea-9cc5-ac409612170a.png">



