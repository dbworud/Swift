## Nested Types
기능 클래스와 구조체를 좀 더 복잡한 타입의 context 안에서 사용하도록 정의
* 중첩을 지원하는 열거형, 클래스, 구조체 내에서 nested type을 정의할 수 있음
* 다른 타입에서 타입을 중첩하기 위해서 타입의 괄호 밖에 정의해야 하며, 타입은 필요한 만큼의 여러 수준으로 중첩가능

```swift
struct BlackjackCard {
  
  // nested Suit enum
  enum Suit: Character {
    case spades = "♠", hearts = "♡", diamonds = "◇", clubs = "♣" 
  }
  
  // nested Rank enum
  enum Rank: Int {
     case two = 2, three, four, five, six, seven, eight, nine, ten
     case jack, queen, king, ace
     
     struct Values {
      let first = Int, second = Int     
     }
     var values: Values {
      switch self {
        case .ace: 
          return Values(first: 1, second: 11)
        case .jack, .queen, .king:
          return Values(first: 10, second: nil)
        default:
          return Values(first: self.rawValue, second: nil)      
        }
     }
  }

  // BlackjackCard properties and methods
  let rank: Rank, suit: Suit
  
  var description: String {
    var output = "suit is \(suit.rawValue),"
    output += "value is \(rank.values.first)"
    if let second = rank.values.second {
      output += " or \(second)"
    }
    return output 
  }
}

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// Prints "theAceOfSpades: suit is ♠, value is 1 or 11"

let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
// heartsSymbol is "♡"

```
