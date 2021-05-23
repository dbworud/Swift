### Enum
* 강력한 기능을 제공
* 각 case는 Lower Camel Case로 정의하며, 그 자체가 고유의 값

**enum 이름 {  
    case 이름1  
    case 이름2  
    case 이름3, 이름4, 이름5  
    ...
}**

```swift
enum Weekday {
  case mon
  case tue
  case wed
  case thu, fri, sat, sun
}

var day: Weekday = Weekday.mon // 처음 선언시 enum이라는 타입을 명시해줄 것
day = .tue // 축약형 

print(day) // tue

switch day {
  case .mon, .tue, .wed, .thu:
    print("평일입니다")
  case Weekday.fri:
    print("불금 파티!!")
  case .sat, .sun:
    print("신나는 주말!!")
}
// case가 하나라도 빠지면, default: 필수
```

* C언의 enum처럼 정수값을 가질 수 있음
* rawValue 사용하면 되고, case 별로 각각 다른 값을 가져야 함
* 자동으로 int 값이 1씩 증가
```swift
enum Fruit : Int {
  case apple = 0
  case grape = 1
  case peach // peach = 2  
}

print("peach value = \(Fruit.peach.rawValue)") // peach value = 2
let apple: Fruit = Fruit(rawValue: 0) // error. nil일 수도 있기 때문에
let apple: Fruit? = Fruit(rawValue: 0) 

if let orange: Fruit = Fruit(rawValue: 5){
  print("rawValue 5에 해당하는 case는 \(orange)입니다")
} else {
  print("rawValue 5에 해당하는 케이스가 없습니다")
} // rawValue 5에 해당하는 케이스가 없습니다
```

```swift
enum School : String {
  case elementary = "초등"
  case middle = "중등"
  case high = "고등"
  case university
}

print("middle value = \(School.middle.rawValue)") // middle value = 중등
print("university value = \(School.university.rawValue)") // university value = university

```
* method도 추가 가능
```swift
enum Month {
  case dec, jan, feb
  case mar, apr, may
  case jun, jul, aug
  case sep, oct, nov
  
  func printMessage() {
    switch self{
      case .mar, .apr, .may:
        print("봄")
      case .jun, .jul, .aug:
        print("여름")
      case .sep, .oct, .nov:
        print("가을")
      case .dec, .jan, .feb:
        print("겨울")
    }
  }
}

Month.mar.printMessage() // 봄 
```


### Class vs Struct vs Enum
#### 1. Class
* 전통적 OOP 관점에서의 class
* 단일 상속
* (인스턴스/타입) 메소드
* (인스턴스/타입) 프로퍼티
* **참조타입** : 데이터를 전달할 때 값의 **메모리 위치**를 전달 = 참조 타입은 모든 변수들이 가리키는 하나의 인스턴스 내부 자체가 바뀜      
--> 값이 변경되면 같이 변경됨 10>20. 20출력 
* Apple framework 대부분의 큰 뼈대는 모두 클래스로 구성


#### 2. Struct
* C언어의 구조체보다 다양한 기능
* 상속 불가
* (인스턴스/타입) 메소드
* (인스턴스/타입) 프로퍼티
* **값 타입** : 데이터를 전달할 때 **값을 복사**하여 전달 = 값 타입은 대입 과정에서 값의 복사가 일어나므로 구조체 변수들이 모두 독립적 객체 가짐       
--> 값을 단순히 복사했기 때문에 원래 값이 변경 안 됨 10>20. 10출력
* Swift의 대부분 큰 뼈대는 모두 구조체로 구성
* 다른 객체 또는 함수 등으로 전달될 때 참조가 아닌 **복사**를 원할 때
* 자신을 상속할 필요가 없거나, 자신이 다른 타입을 상속받을 필요가 없을 때

#### 3. Enum
* 다른 언어의 열거형과는 많이 다른 존재
* 상속 불가
* (인스턴스/타입) 메소드
* (인스턴스/타입) 연산 프로퍼티
* **값 타입**
* 유사한 종류의 여러 값을 유의미한 이름으로 한 곳에 모아 정의 ex. 요일, 상태값, 월(Month) 등
* 열거형 자체가 하나의 데이터 타입, 각 case 모두 유의미한 값으로 취급
* switch-case 구문에서 강력. 코드가 간결&가독성 좋아짐         
* **컴파일 타임에 에러를 확인할 수 있음** <-> 배열이나 딕셔너리는 순서가 바뀌거나 nil값이 들어있는 등 런타입 에러가 발생할 여지가 있으나 enum은 컴파일에서 에러 잡음    
* 구조체 내에 또 다른 구조체는 init하지 않으면 사용할 수 없음. enum은 init을 생성하지 않고 상수로 접근할 수 있음  
* 각 case가 비트단위의 고유값을 가지므로 비교가 빠름 = 비교문에서 강점     
 
 - enum을 너무 많이 사용하면 확장성 측면에서 불리, enum이 수정되면 모든 소스들을 매번 다시 컴파일해야 함

```swift
struct SomeStruct {
  var someProperty: String = "Property"
}

var someStructInstance: SomeStruct = SomeStruct()

func someFunction(structInstance: SomeStruct) {
  var localVar: SomeStruct = structInstance // 복사되어 전혀 다른 새로운 개체 생성
  localVar.someProperty = "ABC"
}

someFunction(someStructInstance)
print(someStructInstance.someProperty) // "Property"

```

```swift
class SomeClass {
  var someProperty: String = "Property"
}

var someClassInstance: SomeClass = SomeClass()

func someFunction(classInstance: SomeClass) {
  var localVar: SomeClass = classInstance
  localVar.someProperty = "ABC"
}

someFunction(someClassInstance)
print(someClassInstance.someProperty) // "ABC"

```

### struct는 '무조건' 값 타입인가? No ex. 구조체 내부에 참조 타입 변수가 있는 경우

```
struct Manufacturer {
    var name: String
}

class Device {
    var name: String
    var manufacturer: Manufacturer
    
    init(name: String, manufacturer: Manufacturer) {
        self.name = name
        self.manufacturer = manufacturer
    }
}

let apple = Manufacturer(name: "Apple")

// 여기서 iPhone, iPad 두 '클래스'는 동일하게 apple이라는 '구조체' 속성을 가짐
let iPhone = Device(name: "iPhone", manufacturer: apple)
let iPad = Device(name: "iPad", manufacturer: apple)

iPad.manufacturer.name = "Google"

print(iPhone.manufacturer.name) // Apple
print(iPad.manufacturer.name) // Google
// Manufacturer는 구조체이므로 값의 복사가 일어남
```
```
class Engine : CustomStringConvertible {
    var description: String {
        return "\(type) Engine"
    }
    
    var type: String
    
    init(type: String) {
        self.type = type
    }
}

struct Airplane {
    var engine: Engine
}

let jetEngine = Engine(type: "Jet")

let bigAirplane = Airplane(engine: jetEngine)
let smallAirplane = Airplane(engine: jetEngine)

smallAirplane.engine.type = "Rocket"

print(bigAirplane.engine.type) // Rocket
print(smallAirplane.engine.type) // Rocket

// class인 engine이 가리키는 변수 모두 수정됨
```
#### Swift에서 Struct 사용을 제일 많이 함
* Swift는 구조체, 열거형 선호
* Apple 프레임워크는 대부분 클래스 사용
* Apple 프레임워크는 사용 시 구조체/클래스 선택은 우리의 몫


