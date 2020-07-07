## Type Casting
* 인스턴스의 타입을 확인하기 위함
* 클래스의 인스턴스를 부모 혹은 자식 클래스의 타입으로 사용할 수 있는지 확인하기 위함
* is, as 사용
* 주로 클래스에서 많이 사용됨

```swift
let someInt: Int = 100
let someDouble: Double = Double(someInt) 
// 엄밀히 말하면, swift에서 타입캐스팅이 아니라 Double타입의 인스턴스를 새로 생성
```

```swift
class Person {
  var name: String = ""
  func breath() {
    print("숨쉬다")
  }
}

class Student: Person {
   var school: String = ""
   func goToSchool() {
    print("등교하다")
   }
}

class UniversityStudent: Student {
  var major: String = ""
  func goToMT() {
    print("MT가다")
  }
}

var yagom: Person = Person()
var jay: Student = Student()
var hannah: UniversityStudent = UniversityStudent()

```

## is
* is를 사용하여 타입을 확인 
```swift
var result: Bool

result = yagom is Person // true
result = yagom is Student // false 
result = yagom is UniversityStudent // false

result = jay is Person // true
result = jay is Student // true
result = jay is UniversityStudent // false

result = hannah is Person // true
result = hannah is Student // true 
result = hannah is UniversityStudent // true

if yagom is UniversityStudent {
  print("yagom은 대학생입니다")
} else if yagom is Student {
  print("yagom은 학생입니다")
} else if yagom is Person {
  print("yagom은 사람입니다")
} // yagom은 사람입니다

switch jay {
case is Person:
  print("jay는 사람입니다")
case is Student:
  print("jay는 학생입니다")
case is UniversityStudent:
  print("jay는 대학생입니다")
default: 
  print("jay는 사람도, 학생도, 대학생도 아닙니다")
} // jay는 사람입니다  -> 첫 case에 걸려서 탈출

```
## as 
### Upcasting
* as를 사용하여 부모클래스의 인스턴스를 사용할 수 있도록 컴파일러에게 타입정보를 전환 
* Any 혹은 AnyObject로도 타입정보를 변환할 수 있음
* 암시적으로 처리되므로 생략해도 무방
* 잘 사용되지는 않음

```swift
var mike: Person = UniversityStudent() as Person // 대학생이 사람의 class가질 수 있음
var jina: Any = Person() // Any는 어떠한 타입도 들어올 수 있으므로 as Any 생략 가능
var jenny: Student = Student()
```

### Downcasting
* 자식 클래스의 인스턴스로 사용할 수 있도록 컴파일러에게 인스턴스의 타입정보를 전환
* as? 또는 as! 사용

### as? 조건부 다운 캐스팅 

```swift
var optionalCasted: Student? // ex. 사람인데 학생인 척 가능?

optionalCasted = mike as? UniversityStudent // 원래 대학생으로 할당되었기 때문에 가능
optionalCasted = jina as? UniversityStudent // nil
optionalCasted = jina as? Person // nil
optionalCasted = jenny as? UniversityStudent // nil
```

### as! 강제 다운 캐스팅

```swift
var forcedCasted: Student

forcedCasted = mike as! UniversityStudent // 원래 대학생으로 할당되었기 때문에 가능
forcedCasted = jina as! UniversityStudent // runtime error
forcedCasted = jina as! Person // runtime error 
forcedCasted = jenny as! UniversityStudent // runtime error

// 활용
func doSomethingWithSwitch(someone: Person) {
  switch someone {
  case is UniversityStudent: 
    (someone as! UniversityStudent).goToMT()
  case is Student: 
    (someone as! Student).goToSchool()
  case is Person: 
    (someone as! Person).breath()
  }
}

doSomethingWithSwitch(someone: mike as Person) // MT가다
doSomethingWithSwitch(someone: mike) // MT가다
doSomethingWithSwitch(someone: jenny) // 등교하다

// if-let 사용하면 casting과 동시에 반환받아서 unwrapping 할 수 있음
func doSomething(someone: Person) {
  if let universityStudent = someone as? UniversityStudent {
    universityStudent.goToMT()
  } else if let student = someone as? Student {
    student.goToSchool()
  } else if let person = someone as? Person {
    person.breath()
  }
}

```
