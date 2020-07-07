### Generic
함수의 기능과 형태가 동일한데, 자료형만 다른 것을 처리하기 위한 반복적인 코딩을 피하기 위해 Generic이라는 자료형을 이용

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int){
  let tempA = a
  a = b
  b = tempA  
}

func swapTwoInts(_ a: inout String, _ b: inout String){
  let tempA = a
  a = b
  b = tempA  
}
```

```swift
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
  let tempA = a
  a = b
  b = tempA
}

var someInt = 3
var anotherInt = 100
swapTwoValues(&someInt, &anotherInt)

var someString = "Hello"
var anotherString = "World"
swapTwoValues(&someString, &anotherString)
```

### Type Parameter = Generic
여러 매개변수를 받을 수 있음

```swift
func testingFunction<A, B>(address: A, year: B){
  // A와 B가 어떤 자료형이 되는 placeholder
  let place: A
  let origin: B
  let something: B
}
```

### Generic Types
Array<Element> 나 Dictionary<Key, Value> 처럼 임의의 Generic Type 제작 가능

```swift
struct Stack<Element> {
  var items = [Element]()
  mutating func push(_ item: Element) {
    items.append(item)
  }
  mutating func pop() -> Element {
    return items.removeLast() // LIFO  
  }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("done")
stackOfStrings.push("finish")

let fromTheTop = stackOfStrings.pop() // finish
```

### Extension in Generic
Type Property를 다시 선언할 필요 없이 원래의 자료형 선언의 것을 그대로 사용하면 됨
```swift
extension Stack {
  var topItem: Element? {
    return items.isEmpty ? nil : items[items.count - 1] // if empty, return nil. otherwise, pop item on the top
  }
}
```

### Type Constraints
Type Parameter에 올 수 있는 특정 자료형에 제한두는 것. ex. 특정 class, subclass, protocol 등
```swift
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
  // function body goes here
  // T는 SomeClass의 subclass여야 하고, U는 SomeProtocol을 따르는 자료형이 오도록 제한
}
```

* Array에서 특정값의 Index를 확인하는 함수로, 첫 함수는 String 자료형에 속박되지만  
두번째 함수는 Type Property를 써서 자료형의 구애를 받지 않고 기능을 하는 함수를 만듦

```swift
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
  for (index, value) in array.enumerated() {
    if value == valueToFind {
      return index
    }
  }
  return nil
}

func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
  for (index, value) in array.enumerated() {
    if value == valueToFind {
      return index
    }
  }
  return nil
}  // Compile Error!
```

Swift의 모든 자료형이 == 를 사용할 수 있는 것은 아니기 때문에 == 를 사용할 수 있는 자료형만  
들어오라고 제한을 주면 된다. 즉, Type Propery에 Equatble이라는 protocol을 따르는 자료형만 받으면 됨
```swift
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
  for (index, value) in array.enumerated() {
    if value == valueToFind {
      return index
    }
  }
  return nil
} 
```

### Protocol에서의 Generic
**associatedtype** : append를 통해 받은 값과 subscript를 통해 접근하는 값의 자료형이 일치하도록 강제 

```swift
protocol Container<T> {
  mutating func append(_ item: T) 
  var count: Int { get }
  subscript(i: Int) -> ItemType { get }
} // Compile Error
```

```swift
protocol Container {
  associated ItemType
  mutating func append(_ item: ItemType)
  var count: Int { get } 
  subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
  typealias ItemType = Int // 생략 가능
  mutating func append(_ item: Int) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> Int {
    return items[i]
  }
}
```

### Generic Where Clauses
**where**를 통해 좀 더 구체적인 Type Constraint. 

```swift
func allItemsMatch<C1: Container, C2: Container>  
(_ someContainer: C1, _ anotherContainer: C2) -> Bool  
where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {

  // check if both containers contain the same number of items
  if someContainer.count != anotherContainer.count {
    return false
  }
  
  // check each pair of items to see if they are equivalent
  for i in 0..<someContainer.count {
    if someContainer[i] != anotherContainer[i] {
      return false
    }
  }
  
  // All items mathch, so return ture
  return true  
}
```

```swift
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("done")
stackOfStrings.push("finish")

var arrayOfStrings = ["uno", "done", "finish"]

if allItemsMatch(stackOfStrings, arrayOfStrings) {
  print("All items match.")
} else {
  print("Not all items match.")
}
// All items match.
```
