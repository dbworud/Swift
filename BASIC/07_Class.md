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


### 1. Designated Initializer(지정생성자)
 - 클래스의 메인 생성자      
 - 반드시 모든 프로퍼티 초기화      
 - 만약 super-class로부터 상속을 받은 클래스라면 생성자의 실행이 완료되기 전에 super-class의 저정생성자를 호출해야 함       
 
 
### 2. Convenience Intializer(편의생성자)
 - 초기화 단계에서 미리 지정된 값을 사용해 최소한의 입력으로 초기화를 도와주는 initializer       
 - 반드시 Designated Initializer(지정생성자) 호출되어야 함        
 - 호출하는 생성자는 반드시 동일 계층에 있는 지정생성자 혹은 편의생성자여야 함       
 - 동일 계층에 있는 편의생성자를 호출하더라도 이 편의생성자는 최종적으로 동일한 클래스 내에 있는 지정생성자를 호출해야 함       
 
 #### 클래스의 생성자는 원칙적으로 상속이 불가능하나 다음 2가지 규칙에 의해 상속이 자동으로 이루어짐      
 1. sub-class의 모든 프로퍼티가 기본값을 초기화되어 있고, init를 구현하지 않았다면, super-class에 있는 모든 init이 상속된다       
 2. sub-class가 모든 initializer를 상속받았거나 오버라이딩 했다면, 모든 편의생성자 상속됨       
 
 그런데, class의 상속성 때문에 subClass에서 designated init에서 super의 convenience init을 호출할 경우 무한 루프에 빠질 수 있음

```
// Initializer Inheritance and Overriding
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[UnNamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let unNamedMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
   
    init(name: String, quantity: Int) {
        self.quantity = quantity // 현재 계층 속성 초기화
        super.init(name: name) // super-class의 생성자 호출 동시에 나머지 속성 초기화
    }

    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) X \(name)"
        output += purchased ? " O" : " X"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6)
]

breakfastList[0].name = "Orange Juice"
breakfastList[0].purchased = true

for item in breakfastList {
    print(item.description)
    // 1 X Orange Juice O
    // 1 X Bacon X
    // 6 X Eggs X
}
```
