swift에서는 대부분 struct타입으로 이루어져 있음   
property와 method    
Value Type, 복사하기 때문에 인스턴스의 주소 다름      

**struct 이름{  
  // 구현부  
}**

```swift
struct Sample{
  //instance property: instance에서 쓸 수 있는 property 
  var mutableProperty: Int = 100 // 가변 property
  let immutableProperty: Int = 100 // 불변 property
  
  static var typeProperty: Int = 100 // type property 
  
  // instance method : instance에서 쓸 수 있는 method
  func instanceMethod() {
    print("instance method")
  }
  
  // type method
  static func typeMethod() {
    print("type method")
  }
}

// Sample이라는 타입의 가변 instance 생성 
var mutable: Sample = Sample() 
mutable.mutableProperty = 200 // 내부 값 변경 가능
mutable.immutableProperty = 200  // 구조체 내에서 불변으로 선언했기 때문에 error

// Sample이라는 타입의 불변 instance 생성 -> 아예 변경 불가 
let mutable: Sample = Sample() 
mutable.mutableProperty = 200 // error
mutable.immutableProperty = 200 // error

// Type property 및 method : 구조체 자체가 사용할 수 있는 property
Sample.typeProperty = 300 
Sample.typeMethod() 

// instance에 type property 나 type method 사용 불가
mutable.typeProperty = 400 
mutable.typeMethod() 
```

```swift
struct Student {
  var name: String = "unknown"
  var 'class': String = "swift" // Class와 중복되면 안되므로
  
  fun selfIntroduce() {
    print("저는 \(self.class)반 \(name)입니다")
  }
  
  static fun selfIntroduce() {
    print("학생 타입입니다")
  }
}

Student.selfIntroduce() // 학생타입입니다

var yagom: Student = Student()
yagom.name = "yagom"
yagom.class = "스위프트"
yagom.selfIntroduce() // 저는 스위프트반 yagom입니다

let jina: Student = Student() // 불변이므로 프로터피 값 변경 불가
jina.selfIntroduce() // 저는 swift반 unknonw입니다 

``` 

### mutating 키워드
 
```
 struct Point {
     var x = 0.0
     var y = 0.0
     
     mutating func moveTo(x deltaX: Int, y deltaY: Int) {
         x += deltaX
         y += deltaY
     }
 }

 var somePoint = Point(x: 1.0, y: 1.0)
 somePoint.moveTo(x: 2.0, y: 3.0)
 
``` 
 
구조체 내부에서 데이터를 수정할 때 선언    
원래, enum과 struct는 값 타입(Value Type)    
값 타입의 프로퍼티는 해당 인스턴스 메소드 내에서 수정할 수 없으나, 특정 메소드 내에서 struct, enum의 프로퍼티를 수정해야 하는 경우 mutating을 사용하는 것   

왜? mutating func를 통해 struct 전체가 복사됨을 명시 -> 인스턴스에 따라 주소값 달라짐   
struct 전체가 복사되는 이유는 swift가 함수형 언어라서 불변성이 중요하기 때문 -> thread-safety 보장    
