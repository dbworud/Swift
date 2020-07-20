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
**Mapping Element** : 주로 데이터를 다른 데이터 타입으로 변형 ex. scan, setFailureType, map, flatMap. 
**Filtering Element** : 조건에 맞느 데이터만 허용 ex. compactMap, replaceEmpty, filter, replaceError, removeDuplicates. 
**Reduce Element** : 데이터 스트림을 모아 출력 ex. collect, reduce, tryReduce, ignoreOutput. 
**Mathematic operations on elements** : 숫자와 관련된 스트림 제어 ex. count, max, min. 
**Sequence Elements** : 데이터 시퀀스를 변형할 때 사용 ex. prepend, firstWhere, tryFirstWhere, first, lastWhere, tryLastWhere, last, dropWhile. 

