#### Optional? 값이 있을 수도, 없을 수도 있음을 뜻함

```swift 
let optionalConstant: Int? = nil
let someConstant: Int = nil // error 

func someFunction(someOptionalParam: Int?){
  // ...
  // someOptional Param can be nil
}

func someFunction(someParam: Int){
  // ... 
  // someParam must not be nil
}

someFunction(someOptionalParam: nil)
someFunction(someParam: nil) // error

```
#### Option = enum + general

```swift
enum Optional<Wrapped> : ExpressibleByBilLiteral {
  case none
  case some(Wrapped)
}

let optionalValue: Optional<Int> = nil
let optionalValue: Int? = nil
```
#### Optional 1. !
암시적 추출 옵셔널 (Implicitly Unwrapped Optional)

```swift
var optionalValue: Int! = 100

switch optinalValue {
  case .none:
    print("This Optional variable is nil")
  case .some(let value):
    print("Value is \(value)")
}

// 기존 변수처럼 사용 가능
optionalVlaue = optionalValue + 1

// nil 할당 가능
optionalVlaue = nil
optionalVlaue = optionalValue + 1 // runtime error

```

#### Optional 2. ?
일반적인 optional

```swift
var optionalValue: Int? = 100

switch optinalValue {
  case .none:
    print("This Optional variable is nil")
  case .some(let value):
    print("Value is \(value)")
}

// nil 할당 가능
optionalVlaue = nil
optionalVlaue = optionalValue + 1 // runtime error
```

### Optional Unwrapping (Optional 추출, 활용법)

#### 1. Optional Binding 옵셔널 바인딩
옵셔널의 값을 꺼내오는 방법 중 하나  
nil 체크 + 안전한 값 추출  
knock를 해서 값이 있으면 추출

```swift
func printName(_ name: String){
  print(name)
}

var myName: String? = nil
print(myName) // 전달되는 값의 타입이 다르기 때문에 컴파일 오류
```

* if-let 방식을 통해 Optional Binding 
```swift
func printName(_ name: String){
  print(name)
}

var myName: String? = nil

if let name: String = myName{
  printName(name)
} else {
  print("myName == nil")
}
```

* 여러 변수들을 함께 Optional binding할 수 있음
```swift
var myName: String? = "yagom"
var yourName: String? = nil

if let name = myName, let friend: yourName {
  print("\(name) and \(friend)") // yourName이 nil이기 때문에 오류 
}

yourName = "Hannah"
if let name = myName, let friend: yourName {
  print("\(name) and \(friend)") // yagom and Hannah
}
```

#### 2. Force Unwrapping 강제추출
옵셔널의 값을 강제로 추출  
knock를 하지 않고 강제로 가져옴  
그다지 권장하지 않음

```swift
func printName(_ name: String){
  print(name)
}

var myName: String? = "yagom"
printName(myName!) // 뒤에 ! 붙여서 강제 추출 yagom

myName = nil
printName(myName!) // runtime error 

var yourName: String! = nil 
printNmae(yourName) // runtime error 
```


