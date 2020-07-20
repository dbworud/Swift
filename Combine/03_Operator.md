## Operator?
생성자와 소비자 중간에 위치하여 데이터 스트림을 가공해주는 역할

<img width="1202" alt="image" src="https://user-images.githubusercontent.com/59492694/87912873-12af8d00-caa9-11ea-9395-e2a959c74480.png">

```swift
class CustomSubscriber: Subscriber {
  // 생략
}

let formatter = NumberFormatter()
formatter.numberStyle = .ordinal
(1...10).publisher.map{
  formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
}.sink{
  print($0)
}
```

## Operator 종류
