### Property
* 구조체, 클래스, 열거형 내부에 구현
* 열거형 내부에는 연산 프로퍼티만 구현 가능

* 저장 프로퍼티(stored property)
* 연산 프로퍼티(computed property) : var로만 선언 가능

* 인스턴스 프로퍼티(instance property)
* 타입 프로퍼티(type property)

```swift
struct Student{

  // 인스턴스 저장 프로퍼티: 값들을 저장하기 위함
  var name: String = ""
  var 'class': String = "Swift"
  var koreanAge: Int = 0
  
  // 인스턴스 연산 프로퍼티: 특정 연산을 수행해주기 위한 프로퍼티
  var westernAge: Int{
    get{
      return koreanAge - 1
    }
    set(intputValue) {
      koreanAge = inputValue + 1
    }
  }
  
  /*
  // 복습, 상기
  // 인스턴스 메서드
  func selfIntroduce() {
    print("저는 \(self.class)반 \(name)입니다")
  }
  
  // 타입 메서드
  static func selfIntroduce(){
    print("학생타입입니다")
  }
  */
  
  
  // 타입 저장 프로퍼티: 타입과 연관돼서 값을 저장
  struct var typeDescription: String = "학생"
  
  // 읽기 전용 인스턴스 연산 프로퍼티
  func selfIntroduction: String{
    get { // get이 있으면 읽기 전용
      return "저는 \(self.class)반 \(name)입니다"
    }
  }
  
  // 읽기 전용 타입 연산 프로퍼티, 읽기 전용에서는 get 생략 가능
  static var selfIntroduction: String {
    return "학생타입입니다"
  }
  
  print(Student.selfIntroduction) // 타입 프로퍼티는 변수에 구조체 선언없이 바로 사용 가능
  
  var yagom: Studennt = Student()
  yagom.koreanAge= 10 
  print("yagom의 한국나이는 \(yagom.koreanAge)살이고 미국나이는 \(yagom.westernAge)살입니다.") 
  // yagom의 한국나이는 10살이고 미국나이는 9살입니다.

```

### 응용

```swift
struct Money {
  var currencyRate: Double = 1100
  var dollar: Double = 0
  var won: Double {
    get {
      return dollar * currencyRate
    }
    set {
      dollar = newValue / currencyRate  // 암시적으로 newValue가 매개변수 
    }
  }
  
  var pocketMoney: Money = Money()
  pocketMoney.won = 11000 // 계산되어서 pocketMoney의 dollar에 값이 저장됨
  print(pocketMoney.dollar) // 10

}
```
### 지역변수, 전역변수에서도 사용 가능
저장 프로퍼티와 연산 프로퍼티의 기능은 함수, 메소드, 클로저, 타입 등의 외부에 위치한  
지역변수 & 전역변수에도 모두 사용 가능

```swift
var a: Int = 100
var b: Int = 200
var sum: Int {
  return a + b
}

print(sum) // 300 
```

### 프로퍼티 감시자
프로퍼티 값이 변경될 때 감시하고 있다가 원하는 동작을 수행할 수 있게 해줌

```swift
struct Money {
  // 프로퍼티 감시자 사용, currencyRate가 변경될 때 아래 willSet, didSet이 수행됨
  var currencyRate: Double = 1100 {
    // 바뀌기 직전에 호출
    willSet(newRate) {
      print("환율이 \(currencyRate)에서 \(newRate)로 변경될 예정입니다")
    }
    // 바뀌고 나서 호출
    didSet(oldRate) {
      print("환율이 \(oldRate)에서 \(currencyRate)로 변경되었습니다")
    }  
  }
  
  // 암시적
  var dollar: Double = 0 {
    willSet {
      print("\(dollar)에서 \(newValue)로 변경될 예정입니다")
    }
    didSet {
      print("환율이 \(oldValue)에서 \(dollar)로 변경되었습니다")
    }
  }
  
  // 연산 프로퍼티 내에서는 사용 불가 
  /*
  var won: Double {
    get {
      return dollar * currencyRate
    }
    set {
      dollar = newValue / currencyRate  // 암시적으로 newValue가 매개변수 
    }
  }
  
  // 프로퍼티 감시자는 값이 변경될 때 수행되기 때문에 willSet, didSet이 들어올 수 없다.  
  */
  
  var pocketMoney: Money = Money()
  pocketMoney.currencyRate = 1150   
  // 환율이 1100.0에서 1150.0로 변경될 예정입니다
  // 환율이 1100.0에서 1150.0로 변경되었습니다
   
  pocketMoeny.dollar = 10 
  // 0.0 달러에서 10.0달러로 변경될 예정입니다 
  // 0.0 달러에서 10.0달러로 변경되었습니다 
  
}

```

### 지역변수, 전역변수에서도 사용 가능
프로퍼티 감시자 기능은 함수, 메소드, 클로저, 타입 등의 외부에 위치한  
지역변수 & 전역변수에서도 모두 사용 가능

```swift
var a: Int = 100 {
  willSet {
    print("\(a)에서 \(newValue)로 변경될 예정입니다")  
  }
  didSet {
    print("\(oldValue)에서 \(a)로 변경되었습니다")  
  }
}

a = 200
// 100에서 200으로 변경될 예정입니다
// 100에서 200으로 변경되었습니다
```


