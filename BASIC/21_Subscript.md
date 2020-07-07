### Subscript
* 컬렉션, 리스트, 시퀀스 타입의 개별 요소에 접근할 수 있는 **지름길** 제공
* let array = [1,2,3]에서 array[1]이라는 index를 통해 value에 접근함. array에는 이미 subscript가 구현되어있기 때문

```swift
subscript(index: Int) -> Int {
  get {
    //return appropriate subscript value here
  }
  set(newValue) {
    // perform a suitable setting action here
  }
}
```

### Example 1: 구구단
struct에 subscript 적용

```swift
struct Table {
  let multiplier: Int
  subscript(index: Int) -> Int {
    return multiplier * index
    // subscript에 입력하는 정수만큼 곱하는 것
    // set없이 읽기 전용
  }
}

let threeTimesTable = Table(multiplier: 3) 
print("six times three is \(threeTimesTable[6])") // index에 6이 입력되었으니 3*6 = 18
```

### Example 2: Movie List
class에 subscript 적용

```swift
class MovieList {
  private var tracks = ["The GodFather", "The Dark Knight", "Superman"]
  subscript(index: Int) -> String {
    get {
      return self.tracks[index]
    }
    set {
      self.tracks[index] = newValue
    }
  } 
}

var movieList: MovieList = MovieList()
print("두번째 영화리스트는 "\(movieLiset[1])") // The Dark Knight
```
