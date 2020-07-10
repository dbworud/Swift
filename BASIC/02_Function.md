
### 반환값이 있는 함수 선언
**func 함수이름 (매개변수1이름: 매개변수1타입, 매개변수2이름: 매개변수2타입 ...) -> 반환타입 {
  함수 구현부
  return 반환값
}**

```swift
func sum(a: Int, b: Int) -> Int {
  retrun a + b
}
```

### 반환값이 없는 함수 선언
**func 함수이름 (매개변수1이름: 매개변수1타입, 매개변수2이름: 매개변수2타입 ...) -> Void {
  함수 구현부
  return 
}**

```swift
func printMyName(name: String) -> Void {
  print(name)
}

func printMyName(name: String) {
  print(name)
}
```

### 매개변수가 없는 함수 선언
**func 함수이름() -> 반환타입 {
  함수 구현부
  return 반환값
}**

```swift
func maximumIntegerValue() -> Int{
  return Int.max
}
```

### 매개변수와 반환값이 없는 함수 선언
**func 함수이름() -> Void {
  함수 구현부
  return
}**

**func 함수이름() {
  함수 구현부
  return
}**

```swift
func hello() -> Void {print("hello")}

func bye() {print("bye")}
```
### 함수호출

```swift
sum(a: 3, b: 5) // 8
printMyName(name: "Jaekyung") // Jaekyung
maximumIntegerValue() // Int의 최댓값()
hello() // hello
bye() // bye
```

### default값을 갖는 매개변수는 가장 뒤에 위치
**func 함수이름(매개변수1이름: 매개변수1타입, 매개변수2이름: 매개변수2타입 = 매개변수 기본값...) -> 반환타입 {
  함수 구현부
  return 반환값
}**

```swift
func greeting(friend: String, me: String = "Jaekyung") {
  print("Hello \(friend)! I'm \(me)")
}

// default가진 경우, 생략 가능
greeting("Hannah") // Hello Hannah! I'm Jaekyung
greeting("Hannah", "Eric") // Hello Hannah! I'm Eric
```

### 전달인자 
함수 호출 시, 매개변수의 역할을 좀 더 명확하게 하거나 함수 사용자의 입장에서 표현하고자 할 때  

**func 함수이름(전달인자 레이블 매개변수1이름: 매개변수1타입, 전달인자 레이블 매개변수2이름: 매개변수2타입...) {
  함수 구현부
  return
}**

```swift
func greeting(to friend: String, from me: String){
  print("Hello \(friend)! I'm \(me)")
}

greeting(to: "Hannah", from: "Jaekyung") 
```
### 가변 매개변수
전달 받을 값의 개수를 알기 어려울 때.
함수 당 하나만 가질 수 있음

**func 함수이름(매개변수1이름: 매개변수1타입, 전달인자 레이블 매개변수2이름: 매개변수2 타입...) -> 반환타입 {
  함수 구현부
  return
}**

```swift
func sayHelloToFriends(me: String, friends: String...) -> Strin g {
  return "Hello \(friends)! I'm \(me)."
}
print(sayHelloToFriends(me: "Jaekyung", friends: "hannah", "jinsol", "jiae"))
// Hello ["hannah", "jinsol", "jiae"]! I'm Jaekyung.
print(sayHelloToFriends(me: "Jaekyung") // Hello []! I'm Jaekyung.
```

### 하나의 데이터 타입으로서 함수
swift의 함수는 일급객체이므로 변수, 상수 등에 저장 가능하며 매개변수를 통해 전달 가능
※변환타입을 생략할 수 없음  

**(매개변수1타입, 매개변수2타입 ...) -> 반환타입**

```swift
var someFunction: (String, String) -> Void = greeting(to:from:) // greeting이란 함수를 someFunction이라는 var에 저장
someFunction("Hannah", "Jaekyung") // Hello Hannah! I'm Jaekyung

someFunction = sayHelloToFriends(me: friends:) // error. friends가 가변매개변수 이기 때문에 String 타입과 맞지 않음

func runAnother(function: (String, String) -> Void) {
  function("jenny", "mike")
}

runAnother(function: greeting(friend:me:)) // Hello jenny! I'm mike
runAnother(function: someFunction) // Hello jenny! I'm mike

```

### 함수에서 argument
```swift
func greet(name: String, day: String) {
  print("Hello, \(name). It's \(day)")
}

func greet(name: String, _day: String) {
  print("Hello, \(name). It's \(day)")
}

greet(name: "John", day: "Wed")
greet(name: "John", "Wed")

함수호출에서 차이! 전자는 argument(인자)의 label이 붙어야 함!
```
