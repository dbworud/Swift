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

### 탈출불가 클로저~~(@noescape)~~
* noescape가 기본값(default)
1. 클로저가 함수의 전달인자로 전달된다  
2. 함수 내부에서 몇몇 작업들을 수행한다   
3. 이제 함수 클로저를 실행한다   
4. 함수 return시, 클로저가 메모리에서 삭제되어 메모리 관리가 수월해짐

```swift
func doSomething() {
    // step 1
    self.getSumOf(array: [16,756,442,6,23]) { (sum) in
        print(sum)
        // step 4. 함수 종료
    }
}

func getSumOf(array:[Int], handler: ((Int)->Void)) {
    // step 2
    var sum: Int = 0
    for value in array {
        sum += value
    }

    // step 3
    handler(sum)
}
```

### 탈출 클로저 (@escaping)
탈출불가 클로저와 달리, 함수가 종료된 후에도 클로저가 필요한 경우 = 클로저가 메모리에 남아있어야 함  
@escaping을 표기하는 경우   
1. 클로저 저장: 글로벌 변수에 클로저를 저장하여 함수가 종료된 후에도 사용하는 경우  
2. 비동기 작업: Dispatch queue등을 사용하여 비동기 작업을 한다면, 클로저를 메모리에 계속 잡아두어 비동기 작업을 마무리하도록 해야 함   

단, **탈출 클로저 내부에서 해당 타입의 프로퍼티나 메소드 등에 접근하려면 반드시 self 키워드를 사용해야 함!!**    

1. 클로저가 함수의 전달인자로 전달된다  
2. 함수 내부에서 몇몇 작업들을 수행한다  
3. 저장 또느 비동기 작업을 위해 클로저 실행   
4. 함수 리턴   

<<클로저 저장>>
```swift
var complitionHandler: ((Int)->Void)?

func getSumOf(array:[Int], handler: @escaping ((Int)->Void)) {
    //step 2
    var sum: Int = 0
    for value in array {
        sum += value
    }
    //step 3
    self.complitionHandler = handler
}

func doSomething() {
    //step 1
    self.getSumOf(array: [16,756,442,6,23]) { (sum) in
        print(sum)
        //step 4. 함수 종료
    }
}
```

<<비동기 작업>>
```swift
func getSumOf(array:[Int], handler: @escaping ((Int)->Void)) {
    //step 2
    var sum: Int = 0
    for value in array {
        sum += value
    }
    //step 3. 비동기 작업
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.0){
        handler(sum)
    }
}

func doSomething() {
    //step 1
    self.getSumOf(array: [16,756,442,6,23]) { (sum) in
        print(sum)
        //step 4. 함수 종료
    }
}
```

