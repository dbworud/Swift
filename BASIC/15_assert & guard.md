### assert & guard
어플리케이션이 동작 도중에 생성하는 다양한 결과값을 동적으로 확인하고 안전하게 처리할 수 있도록 확인하고 빠르게 처리할 수 있음

### assert
* assert(_:_:file:line:) 함수를 사용
* assert 함수는 디버깅 모드에서만 동작, 예상했던 조건들이 확실하게 맞는가 검증
* 배포하는 어플리케이션에서는 동작하지 않음
* 주로 디버깅 중 조건의 검증을 위해 사용

```swift
var someInt: Int = 0
assert(someInt == 0, "someInt != 0") // if someInt == 0, 지나감. else, print "someInt != 0"

func functionWithAssert(age: Int?) {
  assert(age != nil, "age == nil")
  assert( (age! >= 0 ) && (age! <= 130), "나이값 입력이 잘못되었습니다")
  print("당신의 나이는 \(age!)세 입니다")
}

functionWithAssert(age: 50)
functionWithAssert(age: -1) // 동작중지, 검증실패
functionWithAssert(age: nil) // 동작중지, 검증실패
```

### guard
* 디버깅에서만 사용하는 assert와 달리, 어떤 조건에서도 동작
* 잘못된 값의 전달 시 특정 실행구문을 빠르게 종료
* guard의 else 블럭 내부에는 특정 코드블럭을 종료하는 지시어(return, break 등)가 필수
* 타입 캐스팅, 옵셔널과도 자주 사용
* 그 외 단순 조건 판단 후 빠르게 종료할 때 용이 early exit

```swift
func functionWithGuard(age: Int?) {
  
  guard let unwrappedAge = age, // 옵셔널 바인딩을 먼저 실행. age가 nil이라면 바로 return으로
    unwrappedAge < 130,
    unwrappedAge >= 0 
    else {
      print("나이값 입력이 잘못되었습니다")
      return 
    }
    
  print("당신의 나이는 \(unwrappedAge)세 입니다")
}
```

* 함수뿐만 아니라 반복문 내에서
```swift
var count = 1

while true {
  guard count < 3 else {
    break
  }
  print(count)
  count += 1
} 
// 1 
// 2
```

* Dictionary에서 많이 활용
```swift 
func someFunction(info: [String: Any]) {
  guard let name = info["name"] as? String else {
    return
    // name이 dic안에 name이 String으로 casting되어 정상적으로 동작하면 name이라는 곳으로 binding
  }
  guard let age = info["age"] as? Int, age >= 0 else {
    return 
  }
  print("\(name) : \(age)")
}

someFunction(info: ["name": "jenny", "age": "10"] // age가 Int타입이 아니므로 동작중지
someFunction(info: ["name": "mike"] // 나이가 없어 동작중지
someFunction(info: ["name": "yagom", "age": 10] // yagom: 10

``` 
