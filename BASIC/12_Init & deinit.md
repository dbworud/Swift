### Init: 인스턴스 생성
swift의 모든 인스턴스는 초기화와 동시에 모든 프로퍼티에 유효한 값이 할당되어야 한다  
프로퍼티에 미리 기본값을 할당해두면, 인스턴스가 생성됨과 동시에 초기값을 지니게 된다

```swift
class PersonA {
  // 모든 저장 프로퍼티에 기본값 할당
  var name : String = "unknown" // 프로퍼티 생성
  var age: Int = 0 // 프로퍼티에는 초기값이 있어야 함
  var nickName: String = "Nick"
}

let jason: PersonA = PersonA() // 인스턴스 생성
jason.name = "jason"
jason.age = 30
jason.nickName = "jay"
```

### 프로퍼티 기본값을 지정하기 어려운 경우에 initializer를 통해 인스턴스가 가져야 할 초기값을 전달 가능
```swift
class PersonB {
  var name: String
  var age: Int
  var nickName: String
  
  // initializer
  init (name: String, age: Int, nickName: String) {
    self.name = name
    self.age = age
    self.nickName = nickName
  }
}

let jaekyung: PersonB = PersonB(name: "jaekyung", age: 25, nickName: "jay") // 인스턴스 생성
jaekyung.age = 25
```


### 프로퍼티의 초기값이 꼭 필요없을 때 Optional을 사용
```swift
class PersonC {
   var name: String
   var age: Int
   var nickName: String?
   
  // initializer
  init (name: String, age: Int, nickName: String) {
    self.name = name
    self.age = age
    self.nickName = nickName
  }
  
  // initializer
  init (name: String, age: Int) {
    self.name = name
    self.age = age
  }
  
  // OR 자신의 initializer를 사용할 때
  convenience init (name: String, age: Int, nickName: String) {
    self.init(name: String, age: Int) 
    self.nickName = nickName
  }
}

let jenny: PersonC = PersonC(name: "jenny", age: 10)

```
### 암시적 추출 옵셔널은 인스턴스 사용에 꼭 필요하지만, 초기값을 할당하지 않고자 할 때 사용
```swift
class Puppy {
  var name: String
  var owner: PersonC! // owner라는 프로퍼티는 꼭 필요! 추후 초기화 해주겠다
  
  init(name: String) {
    self.name = name  
  }
  
  func goOut() {
    print("\(name)가 주인 \(owner.name)와 산책을 합니다")
  }
}

let happy: Puppy = Puppy(name: "happy")
happy.goOut() // error. 주인의 이름이 없기 때문 
happy.owner = jenny
happy.goOut() // happy가 주인 jenny와 산책을 합니다

```

### 실패가능한 initializer
* initializer 매개변수로 전달되는 초기값이 잘못된 경우, 인스턴스 생성에 실패할 수 있음  
* 인스턴스 생성에 실패하면 nil 반환
* 따라서, 실패가능한 initializer의 반환타입은 옵셔널 타입이다

```swift
class PersonD {
  var name: String
  var age: Int
  var nickName: String?
  
  // Optional Type
  init?(name: String, age: Int) {
    if (0...120).contains(age) === false {
      return nil
    }
    if name.characters.count == 0 {
      return nil
    }
    
    self.name = name
    self.age = age 
  }
}

let joker: PersonD? = PersonD(name: "joker", age: 123)
let batman: PersonD? = PersonD(name: "", age: 10)

print(joker) // nil
print(batman) // nil
```


### Deinit: 인스턴스 소멸 
deinit은 클래스의 인스턴스가 **메모리에서 해제되는 시점에서** 자동으로 호출  
인스턴스가 해제되는 시점에서 해야할 일을 구현할 수 있음  
**클래스**타입에서만 구현 가능

```swift
class PersonE {
  var name: String
  var pet: Puppy?
  var child: PersonC
  
  init(name: String, child: PersonC) {
    self.name = name
    self.child = child
  }
  
  // deinit은 매개변수를 가질 수 없음
  // personE가 deinit될 때 실행
  deinit {
    if let petName = pet?.name {
      print("\(name)가 \(child.name)에게 \(petName)을 인도합니다")
    }
  }
}

var donald: PersonE = PersonE(name: "donald", child: "jenny")
donald?.pet = happy
donald = nil // donald를 메모리에서 해제

// donald가 jenny에게 happy을 인도합니다

```
