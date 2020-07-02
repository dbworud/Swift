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
