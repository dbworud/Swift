### Closure? 
* 코드의 블럭
* 일급 시민(first-citizen)
* 변수, 상수 등으로 저장. 전달인자로 전달이 가능
* 함수: 이름이 있는 클로저. a kind of closure
* 매개변수 없으면 ()로 사용, 반환타입이 없으면 Void로 사용

**{ (매개변수 목록) -> (반환타입) in  
   // 실행코드  
}**

* 함수 vs Closure

```swift
func sumFunction(a: Int, b: Int) -> Int{
  return a + b
}

var sumResult: Int = sumFunction(a: 1, b: 2)
print(sumResult) // 3

var sum: (Int, Int) -> Int = {(a: Int, b: Int) in
  return a + b 
}

sumResult = sum(1, 2)
print(sumResult) // 3

// 함수는 클로저의 일종이므로
// sum이라는 변수에 함수도 할당 가능
sum = sumFunction(a:b:)
sumResult = sum(1, 2)
print(sumResult) // 3
```

* 주로 함수의 전달인자로 사용됨

```swift
let add: (Int, Int) -> Int 
add = { (a: Int, b: Int) -> Int in
  return a + b
}

let substract: (Int, Int) -> Int
substract = {(a: Int, b: Int) -> Int in 
  return a - b
}

let divide: (Int, Int) -> Int 
divide = {(a: Int, b: Int) -> Int in
  return a / b
}

func calculate(a: Int, b: Int, method: (Int, Int) -> Int) {
  return method(a, b)
}

var result: Int

result = calculate(a: 50, b: 10, method: add)
print(result) // 60

result = calculate(a: 50, b: 10, method: substarct)
print(result) // 40

result = calculate(a: 50, b: 10, method: divide)
print(result) // 5

result = calculate(a: 50, b: 10, method: { (left: Int, right: Int ) -> Int in
    return left * right
}) // 바로 코드블럭으로 전달가능 

print(result) // 500 
```

### 후행 클로저
함수의 마지막 전달인자가 클로저라면 마지막 매개변수 이름을 생략한 후  
함수 소괄호 외부에 클로저를 구현할 수 있다.
```swift
func calculate(a: Int, b: Int, method: (Int, Int) -> Int in {
  return method(a, b)
}

var result: Int

result = calculate(a: 10, b: 10) { (left: Int, right: Int) -> Int in
  return left + right 
}
print(result) // 20
```

### 반환타입 생략 가능
Int 타입을 반환할 것임을 알기 때문에 반환타입을 명시해주지 않아도 되지만  
in 키워드는 생략할 수 없음

```swift
result = calcualate(a: 10, b: 10, method: { (left: Int, right: Int) in 
  return left + right
})
print(result) // 20
```

### 단축 인자이름
클로저의 매개변수 이름이 굳이 불필요하다면 단축 인자이름을 활용할 수 있음  
단축 인자이름은 클로저의 매개변수 순서대로 $0, $1... 처럼 표현한다.

```swift
result = calculate(a: 10, b: 10, method: {
  return $0 + $1
})
print(result) // 20
```
### 암시적 반환 표현
클로저가 반환하는 값이 있다면 클로저의 마지막 줄 결과값은 암시적으로 반환값을 취급

```swift
result = calculate(a: 10, b: 10) {
  return $0 + $1
}

print(result) // 20

result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) -> Int in 
    return left+ right
})
result = calculate(a: 10, b: 10) {return $0 + $1 }

```
