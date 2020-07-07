### Error Handling
Error 프로토콜과 (주로) 열거형을 통해 오류 표현

**enum 오류종류이름: Error {  
    case 종류1  
    case 종류2  
    case 종류3  
    // ..  
}**

* 자판기 동작 오류의 종류를 표현

```swift
enum VendingMachineError: Error {
  case invalidInput
  case insufficientFunds(moenyNeede: Int)
  case outOfStock
}
```

* 오류 발생의 여지가 있는 메서드는 throws를 사용
* 자판기 동작 도중 발생한 오류 던지기

```swift
class VendingMachine {
  var itemPrice: Int = 100
  var itemCount: Int = 5
  var deposited: Int = 0
  
  // 돈 받기 메서드
  func receiveMoney(_ money: Int) throws {
    // 입력한 돈이 0 이하이면 오류를 던짐
    guard money > 0 else {
      throw VendingMachineError.invalidInput
    }
    
    // 오류가 없으면 정상처리
    self.deposited += money
    print("\(money)원을 받음")
  }
  
  // 물건 팔기 메소드
  func vend(numberOfItems numberOfItemsToVend: Int) -> String {
    // 원하는 아이템의 수량이 잘못 입력되었으면 오류 던짐
    guard numberOfItemsToVend > 0 else {
      throw VendingMachineError.invalidInput
    }
    
    // 구매하려는 수량보다 미리 넣어둔 돈이 적으면 오류 던짐
    guard numberOfItemsToVend * itemPrice <= deposited else {
      let moneyNeeded: Int
      moneyNeeded = numberOfItemsToVend * itemPrice - deposited
    
      throw VendingMachineError.insufficientFunds(moenyNeeded: money)
    }
    
    // 구매하려는 수량보다 요구하려는 수량이 많으면 오류 던짐
    guard itemCount >= numberOfItemsToVend else {
      throw  VendingMachineError.outOfStock
    }
    
    // 오류가 없으면 정상처리 합니다
    let totalPrice = numberOfItemsToVend * itemPrice
    
    self.deposited -= totalPrice
    self.itemCount -= numberOfItemsToVend 
    
    return "\(numberOfItemsToVend)개 제공함"
  }
}

// 자판기 인스턴스
let machine: VendingMachine = VendingMachine()

// 판매 결과를 전달받을 변수
var result: String?
```

* 오류발생의 여지가 있는 throws 함수(메소드)는 **try** 와 **do-catch**을 활용하여 오류 발생에 대비
* try, try?, try!

```swift
do{
  try machine.receiveMoney(0) // thorw error, try구문에서 오류가 발생했으면 catch로!
} catch VendingMachineError.InvalidInput {
  print("입력이 잘못되었습니다.")
} catch VendingMachineError.insufficientFunds(let moneyNeeded){
  print("\(moneyNeeded)원이 부족합니다")
} catch VendingMachine Error.outOfStock {
  print("수량이 부족합니다")
}  // 입력이 잘못 되었습니다
```

* switch 구문 활용하기 
```swift
do {
  try machine.receiveMoney(300)
} catch /*(let error) 암시적으로 넘어옴*/ {

  switch error {
    case VendingMachineError.invalidInput: 
      print("입력이 잘못되었습니다")
    case VendingMahcineError.insufficientFunds(let moneyNeeded):
      print("\(moneyNeeded)원이 부족합니다")
    case VendingMachineError.outOfStock:
      print("재고가 없습니다")
    default:
      print("알 수 없는 오류 \(error)")
  }
} // 300원 받음

```

* 간결한 표현
```swift
do {
  result = try machine.vend(numberOfItems: 4)
} catch {
  print(error)
} // insufficientFunds(100)
```

```swift
do {
  result = try machine.vend(numberOfItems: 4)
}
```

### try?
* 별도의 오류처리 결과를 통보받지 않고 오류가 발생했으면 결과값을 nil로 돌려받을 수 있음
* 정상동작 후에는 옵셔널 타입으로 정상 반환값을 돌려 받음

```swift
result = try? machine.vend(numberOfItems: 2)
result // 정상 동작 시, Optional("2개 제공함")

result = try? machine.vend(numberOfItems: 2)
result // 오류 발생 시, nil
```

### try!
* 오류가 발생하지 않을 거라는 확신이 강할 때 정상동작 후에 바로 결과값을 돌려받음
* 오류 발생 시 런타임 오류 발생, 어플리케이션 동작 중지

```swift
result = try! machine.vend(numberOfItems: 1)
result // 1개 제공함
```
