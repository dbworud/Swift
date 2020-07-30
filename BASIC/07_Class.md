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

```swift
class Student {
  var name: String = "unknown"
  var 'class': String = "swift" // Class와 중복되면 안되므로
  
  func selfIntroduce() {
    print("저는 \(self.class)반 \(name)입니다")
  }
  
  static func selfIntroduce() {
    print("학생 타입입니다")
  }
}

Student.selfIntroduce() // 학생타입입니다

var yagom: Student = Student()
yagom.name = "yagom"
yagom.class = "스위프트"
yagom.selfIntroduce() // 저는 스위프트반 yagom입니다

let jina: Student = Student() // 불변이므로 프로터피 값 변경 불가
jina.name = "jina"
jina.selfIntroduce() // 저는 swift반 jina입니다 
```


### Struct VS. Class
```swift
struct A {
    var a = 10
}

class B {
    var a = 10
}

class C : B {
    var id = 5
}

var strA = A()
var clsB = B()

var strAA = strA // 값을 복사
var clsBB = clsB // 값을 참조

strA.a = 20 // 10>20. 10
clsB.a = 10 // 10>20. 20

print("\(strAA.a) \(clsBB.a)")

--------
10 20

```
 
struct는 주로 JSON 디코딩할 때 사용, 단순하게 복사하기 때문에 원래 값(rawValue)이 바뀔 위험이 없음   
class는 다른 class를 상속받을 수 있음   

### Rule
* 모델 크기가 크지 않고 상속이 필요없다면 -> struct
* JSON field와 1:1 mapping이 필요하다면 -> struct
* 해당 모델을 serialize하여 전송하거나 파일로 저장한다면 -> class
* 해당 모델이 obj-c에서도 사용되어야 한다면 -> class


