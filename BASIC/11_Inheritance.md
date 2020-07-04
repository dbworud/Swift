### Inheritance
* 클래스, 프로토콜 등에서 사용 가능
* 열거형, 구조체는 상속이 불가능
* 스위프트는 다중상속을 지원하지 않으며 단일상속만 허용 

### 클래스 상속

**class 이름: 상속받을 클래스 이름 {  
  // 구현부  
}**

```swift
class Person {
  var name: String = ""
  
  func selfIntroduce() {
    print("저는 \(name)입니다")
  }
  
  // final 키워드를 통해 재정의 방지, 즉 자식클래스에서 재정의 불가 
  final func sayHello() {
    print("Hello")
  }
  
  // 재정의 불가 타입 메서드 - static 
  static func typeMethod() {
    print("type method - static")
  }
  
  // 재정의 가능 타입 메서드, 자식 클래스에서 재정의 가능 override
  class func classMethod() {
    print("type method - class")
  } 
  
  // 재정의 가능한 class더라도, final 키워드가 붙으면 재정의 불가   
  final class func finalClassMethod() {
    print("type method - final class")
  }
}

class Student: Person {
  // var name: String = "" 이미 Person 구조체에 있는 변수
  var major: String = ""
  
  override func selfIntroduce() {
    print("저는 \(name)이고, 전공은 \(major)입니다")
    super.selfIntroduce() // 부모클래스(=super)에 있는 selfIntroduce 호출
  }
  
  override class classMethod() {
    print("overriden type method - class")
  }
  
  // 아래는 재정의 불가
  override func sayHello() { }
  override static func typeMethod() { }
  override class func finalClassMethod() { }   
 
}

let yagom: Person = Person()
let jay: Student = Student()

yagom.name = "yagom"
jay.name = "jay"
jay.major = "swift"

yagom.selfIntroduce() // 저는 yagom입니다.
jay.selfIntroduce() // 저는 jay이고, 전공은 swift입니다

Person.classMethod() // type method - class
Person.typeMethod() // type method - static 

```
