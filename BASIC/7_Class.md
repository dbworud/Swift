### Class 
* 구조체와 유사
* struct는 값 타입 vs class는 참조 타입
* class는 다중상속이 안 됨

**class 이름 {  
    // 구현부  
}**

```swift
class Sample {
  var mutableProperty: Int = 100 
  let immutableProperty: Int = 100
  
  static var typeProperty: Int = 100
  
  func instanceMethod() {
    print("instance method")
  }
  
  // 타입 메소드1. 재정의 불가 
  static func typeMethod() {
    print("type method - static")
  }
  
  // 타입 메소드2. 재정의 가능 
  class func classMethod() {
    print("type method - class")
  }
}

var mutableReference: Sample = Sample()
let immutableReference: Sample = Sample()

mutableReference.mutableProperty = 200 
immutableReference.mutableProperty = 200 // sturct와 달리, let 상수도 변경 가능

// type property & method
Sample.typeProperty = 300
Sample.typeMethod() 
```
