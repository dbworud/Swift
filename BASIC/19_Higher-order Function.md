### 고차함수
* Swift에서 유용
* 전달인자로 함수를 받거나 함수실행의 결과를 함수로 반환하는 함수

### map
컨테이너 내부의 기존 데이터를 변형하여 새로운 컨테이너 생성

```swift
let numbers: [Int] = [0, 1, 2, 3, 4, 5]
var doulbedNumbers: [Int]
var strings: [String]

doubledNumbers = [Int]()
strings = [String]()

// for 구문 사용시
for number in numbers {
  doubledNumbers.append(number * 2) 
  strings.append("\(number)")
}

// map 메서드 사용시
doubledNumebrs = numbers.map({ (number: Int) -> Int in 
  return number * 2
})

strings = numbers.map({ (number: Int) -> String in 
  return "\(number)"
})

print(doubledNumbers) //[0, 2, 4, 6, 8]
print(strings) // ["0", "1", "2", "3", "4"]

// 매개변수, 반환타입, 반환 키워드 생략. 후행 클로저
doubledNumbers = numbers.map{ $0 * 2 }
```

### filter
하나하나 요소를 필터링해서 새로운 배열로 반환

```swift
var filtered: [Int] = [Int]()

// for 구문 사용 시, 변수 사용에 주목
for number in numbers {
  if number %  2 == 0 {
    filtered.append(number)
  }
}

print(filtered) // [0, 2, 4]

// filter 메소드 사용 시
let evenNumbers: [Int] = numbers.filter {
  (number: Int) -> Bool in
  
  return number % 2 == 0 // number % 2 == 0 이 true일 때만 새로운 컨테이너에 들어갈 것
}

// 매개변수, 반환타입, 반환 키워드 생략. 후행 클로저
let oddNumbers: [Int] = numbers.filter { $0 % 2 != 0}

print(evenNumbers) // [0, 2, 4]
print(oddNumbers) // [1, 3]
```

### reduce
컨테이너 내부의 콘텐츠를 하나로 통합

```swift
let someNumbers: [Int] = [2, 8, 15]

// for 구문 사용 시 변수 사용에 주목
var result: Int = 0

for numbers in someNumbers {
  result += number
}
print(result) // 25

// reduce 메서드 사용 시 초기값이 0이고 someNumbers 내부의 모든 값을 더함
let sum: Int = someNumbers.reduce( 0, {
  (first: Int, second: Int) -> Int in
  
  return first + second
})

let sub: Int = someNumbers.reduce( 0, {
  (first: Int, second: Int) -> Int in
  
  return first - second
})

let sumFromThree = someNumbers.reduce(3) { $0 + $1 }
let multiply = someNumbers.reduce(1) { $0 * $1 }

print(sum) // 25
print(sub) // -25
print(sumFromThree) // 28
print(multiply) // 240
```
