### Protocol
특정 역할을 수행하기 위한 메서드, 프로퍼티, 이니셜라이저 등의 요구사항을 정의  
= 구조체, 클래스, 열거형 등에 '이 기능이 꼭 필요해! 이 기능을 구현했어야 해'라고 강요

* 구조체, 클래스, 열거형은 프로토콜을 채택(Adopted)해서 프로토콜의 요구사항을 실제로 구현할 수 있음
* 어떤 프로토콜의 요구사항을 모두 따르는 타입은 '프로토콜을 준수한다(conform)'고 표현
* 프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 기능을 모두 구현해야 한다
* 사용자와 컴파일러 입장에서, 이 타입은 이러이러한 기능을 수행하고 있음을 알 수 있다

**protocol 프로토콜 이름 {  
    // 정의부  
}**

* 요구사항은 항상 var 키워드 사용
* get은 읽기만 가능해도 상관 없음
* get과 set을 모두 명시하면 읽기 쓰기 모두 가능한 프로퍼티여야 한다
* 프로토콜에서 직접 구현하는 것이 아니라 이런 것들이 필요하다는 것만 명시 -> type에서 구현

```swift
protocol Talkable {
  // '말할 수 있다'라는 기능을 요구하는 프로토콜
 
  // 프로퍼티 요구
  var topic: String { get set }
  var language: String { get }
  
  // 메서드 요구
  func talk()
  
  // initialize 요구
  init(topic: String, language: String) 
}
```

### Protocol 채택 및 준수
```swift
struct Person: Talkable {

  // 저장 프로퍼티
  var topic: String // 읽기쓰기 가능
  let language: String // 읽기 전용
  
  // 연산 프로퍼티로 대체 가능
  var language: String { return "한국어" } // { get { return "한국어"} } 
  
  var subject: String = ""
  var topic: String {
    set {
      self.subject = newValue
    }
    get {
      return self.subject
    }
  }
  
  fun talk() {
    print("\(topic)에 대해 \(language)로 말합니다")
  }
  
  init(topic: String, language: String) {
    self.topic = topic
    self.language = language
  }
}
```

### Protocol 상속
* 프로토콜은 클래스와 다르게 다중상속이 가능

**protocol 프로토콜 이름: 부모 프로토콜 이름 목록 {  
    //정의부  
}**

```swift
protocol Readable {
  func read()
}

protocol Writable {
  func write()
}

protocol ReadSpeakable: Readable {
  //func read()이 이미 Readable로부터 상속받음
  func speak()
}

protocol ReadWriteSpeakable: Readable, Writable {
  // func write()
  //func read()
  func speak() 
}

struct SomeType:  ReadWriteSpeakable {
  func read() {
    print("Read")
  }
  func write() {
    print("Write")
  }
  func speak() {
    print("Speak")
  }
  // func 하나라도 빠지면 에러 발생
}

```

### 클래스 상속과 프로토콜 채택 동시에
상속받으려는 클래스를 먼저 명시하고 그 뒤에 채택할 프로토콜 목록 작성

```swift
class SuperClass: Readable {
  func read() { print("read") }
}

class SubClass: SuperClass, Writable, ReadSpeakable {
  func write() { print("write") }
  func speak() { print("speak") }
}
```

### Protocol 준수 확인
is, as 연산자를 통해 인스턴스가 특정 프로토콜을 준수하는 지 확인할 수 있음

```swift 
let sup: SuperClass = SuperClass()
let sub: SubClass = SubClass()

var someAny: Any = sup
someAny is Readable // true
someAny is ReadSpeakable // false

someAny = sub
someAny is Readable // true
someAny is ReadSpeakable // true

someAny = sup 

// casting해서 확인
if let someReadable: Readable = someAny as? Readable {
  someReadable.read() // read
}

ife let someReadSpeakable: ReadSpeakable = someAny as? ReadSpeakable {
  someReadSpeakable.speak() // 동작 중지
}
```
