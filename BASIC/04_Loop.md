반복문은 Array, Dictionary, Set과 같은 collection 타입과 자주 쓰임

## for-in 구문
**for item in list {
  code
}** 
* break,continue 사용O
* return 사용X

```swift
var integers = [1, 2, 3]
let people = ["yagom": 10, "eric": 15, "mike": 12]

for integer in integers {
  print(integer) // 1, 2, 3
}

for (name, age) in people {
  print("\(name): \(age)")
} // yagom: 10, eric: 15, mike: 12
```

## forEach
* for-in과 동일하게 element 출력
* break,continue 사용X
* return 사용O

```swift
let array = [1,2,3,4,5]
for num in array { 
  if num == 2 {
    break
  }
  print(num)
} // 1

for num in array { 
  if num == 2 {
    continue
  }
  print(num)
} // 1,3,4,5

for num in array { 
  if num == 2 {
    return
  }
  print(num)
} // 오류

array.forEach {
 if $0 == 2 {
    return
  }
  print($0)
} // 1,3,4,5

```

## while 구문
condition에는 Bool type으로! 
**while condition {
  code
}** 

```swift
while integers.count > 1 {
  integers.removeLast() // 3
}
```

## repeat-while 구문
code 부분 실행 후 while 조건문 확인 후, repeat or not. 
C언어의 do-while과 같은 기능 but Swift에서는 do가 오류 처리 시 사용되기 때문

**repeat{
  code
}while condition

```swift
repeat{
  integers.removeLast()
}while integers.count > 0
```

