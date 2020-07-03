## If-else

```swift
let someInteger = 100

if someInteger < 100 {
  print("100 미만")
} else if someInteger > 100 {
  print("100 초과")
} else{
  print("100")
}
```
swift의 조건에는 항상 Bool 타입이 들어와야 합니다. someInteger은 Bool 타입이 아닌 Int 타입이기 때문에 컴파일 오류
```swift
if someInteger {} // error 
```

## Switch 
default 필수  
break 필요 없음 

```swift
switch someInteger{
  case 0: 
    print("zero")
  case 1..<100:  
    print("1~99")
  case 100:
    print("100")
  case 100...Int.max:
    print("over 100")
  default:
    print("unknown")
}
```
정수 외의 대부분의 기본 타입 사용 가능

```swift
switch "yagom"{
  case "jake":
    print("jake")
  case "mina":
    print("mina")
  case "yagom":
    print("yagom!!")
  default:
    print("unknown")
}


```swift
switch "yagom"{
  case "jake", "mina":
    print("jake, mina")
  case "yagom":
    print("yagom!!")
  default:
    print("unknown")
}


```swift
switch "yagom"{
  case "jake":
    print("jake")
    fallthrough // jake 다음, mina까지. break를 써주지 않은 것처럼 동작
  case "mina":
    print("mina")
  case "yagom":
    print("yagom!!")
  default:
    print("unknown")
}
```







