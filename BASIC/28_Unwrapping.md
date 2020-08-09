### 1. Optional Type 선언
nil값이 될 수 있는 상수/변수의 타입 뒤에 '?'을 붙이는 것    
Optional Type은 **1) nil 대입 가능, 2) 자동 초기화**     

### 2. Optional Type을 사용하기 위해서는 Unwrapping이 필요함!
Unwrapping: 옵셔널 타입의 변수에서 유효한 값 얻어오기    
강제 언래핑은 **1)객체 생성, 2)메소드 호출, 3)프로퍼티 접근, 4)옵셔널 체인**에 사용된다
강제 언래핑을 할 경우 runtime error일으키므로 옵셔널 바인딩을 통해 nil 체크 후 언래핑을 한다

```swift
var optional: String? = nil
print(optional!) // 강제 언래핑 -> nil일 경우, error 호출
```

### 3. 옵셔널 바인딩 기법 소개
#### 3-1. if let 
if문 안에서 let 변수에 넣어주는 값이 nil인지 체크하고 nil이 아니면 값을 가져옴

```swift
if let realStr = optionalStr {
  print("A")
} else {
  print("nil")
}
```

#### 3-2. guard
nil체크와 동시에 조건문도 함께 가능

```swift
func bindingWithWhere() {
  guard let val = nilAvailable, val > 0 {
    return;
  } else{
    print("val은 nil이 아니고, 0보다 큰 값이다")
  }
}
```

#### 3-3. 다중바인딩, 
