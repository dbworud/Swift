### Optional Chaining
구조체, 클래스 선언 시 구조체 안에 구조체, 구조체 안에 또다른 인스턴스 이런 식으로 프로퍼티를 타고 타고 가는 경우가 발생  
옵셔널 요소 내부의 프로퍼티로 또다시 옵셔널이 연속적으로 연결되는 경우 유용하게 사용  

```swift
class Person {
  var name: String
  var job: String?
  var home: Apartment? 
  
  init(name: String) {
    self.name = name
  }
}

class Apartment {
  var buildingNumber: String
  var roomNumber: String
  var 'guard': Person?
  var owner: Person?
  
  init(dong: String, ho: String){
    buildingNumber = dong
    roomNumber = ho
  }
}

let yagom: Person? = Person(name: "yagom")
let apart: Apartment? = Apartment(dong: "101", ho: "202")
let superman: Person? = Person(name: "superman")
```

옵셔널 체이닝 실행 후 결과값이 nil일 수 있기 때문에 결과 타입도 optional입니다  

### 만약 우리집의 경비원의 직업이 궁금하다면?  
* Optional Chaining을 사용하지 않는 경우: if-let으로 타고 타야한다 -> 복잡
```swift
func guardJob(owner: Person?) {
  if let owner = owner {
    if let home = owner.home {
      if let 'guard' = home.guard {
        if let guardJob = 'guard'.job {
          print("우리집 경비원의 직업은 \(guardJob)입니다")
        } else {
          print("우리집 경비원은 직업이 없어요")
        }
      }
    }
  }
}

guardJob(owner: yagom)
```

* Optional Chaining을 사용한 경우 - 연쇄작용을 통해서 ?가 성립되며니 다음 단계로 넘어감
```swift
func guardJobWithOptionalChaining(owner: Person?) {
  if let guardJob = owner?.home?.guard?.job {
    print("우리집 경비원의 직업은 \(guardJob)입니다  
  } else {
    print("우리집 경비원은 직업이 없어요")
  }

guardJobWithOptionalChaining(owner: yagom) // 우리집 경비원은 직업이 없어요

yagom?.home?.guard?.job // yagom의 home이 초기화가 되어있지 않으므로 nil
yagom?.home = apart
yagom?.home // Optional(Apartment)

yagom?.home?.guard // nil
yagom?.home?.guard = superman
yagom?.home?.guard?.job = "경비원"
```

### nil 병합 연산자
* ?? 
* ?? 앞에 있는 값이 nil이라면 뒤에 값을 반환해달라

```swift
var guardJob: String

guardJob = yagom?.home?.guard?.job ?? "슈퍼맨"
print(guardJob) // 현재 nil이 아니므로, 경비원 반환

yagom?.home?.guard?.job = nil

guardJob = yagom?.home?.guard?.job ?? "슈퍼맨"
print(guardJob) // 슈퍼맨 반환

```
