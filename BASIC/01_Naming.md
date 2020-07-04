## NAMING
* 기본적으로 Camel Case 
function, method, variable, contant -> Lower Camel Case ex.someVariableName  
type(class, struct, enum, extension...) -> Upper Camel Case ex. Person, Point, Week 

* 대소문자 구분

## Consol log
* print : 단순 문자열 출력
* dump : 인스턴스의 자세한 설명까지 출력

## 문자열 보간법
* String interpolation, 문자열 내에 변수 또는 상수의 실질적인 값을 표현하기 위해 사용

```swift
import Swift
let age: Int = 10

print("안녕하세요! 저는 \(age)살입니다.")
print("안녕하세요! 저는 \(age+5)살입니다.")

``` 
"안녕하세요! 저는 10살입니다."   
"안녕하세요! 저는 15살입니다."

```swift
class Person{
  var name: String ="yagom"
  var age: Int = 10
}

let yagom: Person = Person()
print(yagom)
print("\n#################")
dump(yagom) // 더 자세하게 찍힘
```

## 상수, 변수 선언
```swift
let name : type = value // 상수선언, 값을 변경 시 컴파일 오류
var name : type = value // 변수선언

// 타입이 명확하지 않은 경우 
let name = value
var name = value

//상수든 변수든 나중에 할당하려는 경우 타입 명시!
let sum: Int
let inputA : Int = 100
let inputB : Int = 200
sum = inputA+ inputB // 이 후, 값 변경 불가

var nickname : String
print(nickName) // 컴파일 오류 

```

## 기본 데이터 타입
```swift
// Bool, Int, UInt, Float, Double, Character, String
var someBool : Bool = true 

var someInt : Int = -100
var someUInt : UInt = 100 // unsigned Int 

var someFloat : Float = 3.14 // 32bit 부동소수
someFlaot = 3 // ok

var someDouble : Float = 3.14 // 64bit 부동소수
someFlaot = 3 // error
  
var someCharacter : Character = "a" // 한 문자의 unicode 모두 표현

var someString : String = "aaa" 
someString = someString + "bbb" // "aaabbb"

```

## Any, AnyObject, nil
```swift
/*
Any: Swift의 모든 타입을 지칭
AnyObject: 모든 클래스를 지칭하는 프로토콜
nil: 없음, null
*/

var someAny: Any = 100
someAny = "모든 타입 수용 가능합니다."
someAny = 123.12

class SomeClass{}
var someAnyObject : AnyObject = SomeClass()

someObject = nil // error
someAnyObject = nil // error 
```
## Collection type
```swift
/*
Array: 순서가 있는 list collection. index가 있음
Dictionary: 키(key)-값(value)의 쌍으로 이루어진 collectino
Set: 순서가 없고 멤버가 유일한 collection 
*/

// emtpy array 생성
var integers: Array<Int> = Array<Int>() // []
integers.append(1) // [1]
integers.append(100) // [1,100]
integers.append(100.1) // error

integers.contains(100) // if it contains certain value, return true 
integers.contains(99) // false

integers.remove(at: 0) // 0번 index에 있는 값을 remove. 1
integers.removeLast() // 100 
integers.removeAll() // []

integers.count // 0
integers[0] // empty, so error 

// Array 생성의 다양한 방법
var doubles: Array<Double> = [Double]() // Array<Double>() 과 동일
var strings : [String] = [String]()
var characters: [Character] = [] 

let immutableArray = [1,2,3] // can't change
immutableArray.append(4) // error
immutableArray.removeAll() //error
```

```swift
// Dictionary
// key는 string, value가 any인 empty dictionary 생성
var anyDictionary : Dictionary<String, Any> = [String: Any]() 
anyDictionary["firstKey"] = "value"
anyDictionary["secondKey"] = 100

anyDictionary // ["firstKey" : "value", "secondKey" : 100]

anyDictionary["firstKey"] = "dictionary" //  ["firstKey" : "dictionary", "secondKey" : 100]

anyDictionary.removeValue(forKey: "secondKey") // remove method1
anyDictionary["firstKey"] = nil // remove method2

anyDictionary  // [:]

let emptyDictionary: [String: String] = [:] 
let initializedDictionary: [String: String] = ["name": "Jaekyung", "gender": "female"] // 값 변경 불가
```

```swift
// empty Set 생성, 축약형 없음
var intergerSet: Set<Int> = Set<Int>()
integerSet.insert(1)
integerSet.insert(100)
integerSet.insert(99)
integerSet.insert(99) // 중복X

integerSet // {100, 99, 1}
integerSet.contains(1) // true
integerSet.contains(2) // false

integerSet.remove(100) // 100
integerSet.removeFirst() // 99

integerSet.count // 1

let setA: Set<Int> = [1, 2, 3, 4, 5] 
let setB: Set<Int> = [3, 4, 5, 6, 7]

let union: Set<Int> = setA.union(setB)  // {2,4,5,6,7,3,1} 정렬X

let sortedUnion: [Int] = union.sorted()  // [1,2,3,4,5,6,7] sorted

let intersetion: Set<Int> = setA.intersection(setB) // {5,3,4} 차집합

let subtraction: Set<Int> = setA.subtracting(setB) // {2,1}

```






