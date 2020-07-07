## Extension
* 구조체, 클래스, 열거형, 프로토콜 타입에 새로운 기능을 추가할 수 있는 기능
* 기능을 추가하려는 타입의 구현된 소스 코드를 알지 못하거나 볼 수 없다 해도, 타입만 알고 있으면 그 타입의 기능을 확장할 수 있다
* 기존에 존재하는 기능을 재정의 X
* 익스텐션으로 추가할 수 있는 기능
  + 연산 타입 프로퍼티 / 연산 인스턴스 프로퍼티
  + 타입 메서드 / 인스턴스 메서드
  + 이니셜라이저
  + 서브스크립트
  + 중첩 타입
  + 특정 프로토콜을 준수할 수 있도록 기능 추가
  
  **extension 확장할 타입 이름 {  
      // 타입에 추가될 새로운 기능 구현  
  }**
  
* 기존에 존재하는 타입이 추가적으로 다른 프로토콜을 채택할 수 있도록 확장 가능  
  **extension 확장할 타입 이름: 프로토콜1, 프로토콜2, 프로토콜3... {  
      // 프로토콜 요구사항 구현  
  }** 
     
## 연산 프로퍼티 추가
```swift
extension Int {
  var isEven: Bool {
    return self % 2 == 0
  }
  var isOdd: Bool {
    return self % 2 == 1
  }
}

print(1.isEven) // false
print(2.isEven) // true
print(1.isOdd) // true
print(2.isOdd) // false

var number: Int = 3
print(number.isOdd) // true
```

## 메서드 추가
```swift
extension Int {
  func multiply(by n : Int) -> Int {
    return self * n
  }
}

print(3.multiply(by: 2)) // 6
```

## 이니셜라이저 추가
```swift
extension String {
  init(int: Int) {
    self = "\(int)"
  }
  init(double: Int) {
    self = "\(double)"
  }
}

let stringFromInt: String = String(int: 100) // "100"
print(stringFromInt)
```
