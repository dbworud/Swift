## 데이터 바인딩 
사용자에게 데이터를 어떻게 보여주냐가 UI에서 가장 핵심

### @State ?
뷰가 접근가능하도록 값을 가지고 있느 프로퍼티 래퍼(Property Wrapper)
Property Wrapper : 사용자가 별도의 코딩없이 어노테이션만 선언해도 뷰에서 수정이나 읽기가 가능하도록 캡슐화를 대신 해줌(아래 설명)

```swift
struct ContentView: View {
  @State var isToggleOn: Bool = true
  
  var body: some View {
    VStack {
      // $가 붙으면 값을 수정가능한 Binding타입을 참조
      Toggle(isOn: $isToggleOn){
        Text("글자를 가립니다")
      }.padding()
    
      if isToggleOn {
        Text("글자를 보여줍니다")
    }
  }
}
```
isToggleOn -> Bool
$isToggleOn -> Binding<Bool>, 프로퍼티 래퍼 자체르 받기 때문에 안에 있는 WrapperValue 자체를 변경할 수 있음

### @Binding ?
만약 리스트뷰와 토글뷰가 나뉘어 토글에 따라 리스트를 바꾸어야 하는 경우, 뷰를 다시 그려야함  
두 개의 뷰가 하나의 State를 참조해야 하는 경우가 생기는데 이 때 @Binding이 용이  
하지만, State는 Toggle의 on/off와 같이 UI상태값과 같은 아주 한정된 용도로 사용 권장(뷰 안에만 사용하는 메모리 공간)

```swift
struct ContentView: View {
  @State var isToggleOn: Bool = true
  
  var body: some View {
    VStack{
      
      // Binding<Bool> 형태로 리턴하기 위해 $을 붙여준다
      ChildView(isToggleOn: $isToggleOn)
      if isToggleOn {
        Text("글자를 보여줍니다")
      }
    }
  }
}

struct ChildView: View {
  // Binding으로 받으면 Biniding<Bool>을 인자로 받아 초기화시킬 수 있다
  @Binding var isToggleOn: Bool

  var body: some View {
    Togge(isOn: $isToggleOn){
      Text("글자를 가립니다")
    }.padding()
  }
}

```

### @ObservableObject ?
@Binding의 한정된 사용으로 인해, 뷰 밖의 클래스에서 사용할 경우 별도의 클래스를 만들어 ObservableObject 프로토콜을 따르도록 한다  
 ```swift
 class CountRepo: ObservableObject {
  @Published var count: Int = 0 // @Published는 값이 변동되었을 때 즉각 View에게 알려주는 어노테이션
 }
 
 struct ContentView: View {
  
  @ObservedObject var countRepo = CountRepo()
  var body: some View {
    VStack{
      Text("\(self.countRepo.count)").font(.largeTitle)
      Button("숫자 증가") {
        self.countRepo.count += 1
      }
    }
  }
 }
 ```

@Published를 지우고 실행한다면 버튼을 누르면 값은 바뀌지만 UI는 바뀌지 않는다  
특정 조건식에 의해 UI를 변동시킬 수 있다

```swift
class CountRepo: ObservableObject {
  var count: Int = 0 {
    willSet(newValue) {
      print(newValue % 5)
      if(newValue % 5 == 0){
        objectWillChange.send() // 5번 버튼을 눌렀을 때만 텍스트가 바뀜
      }
    }
  }
}

```

### @EnvironmentObject ?
별도로 값을 전달해주지 않아도 상속받는 부모로부터 함께 적용되는 오브젝트
최상위뷰(SceneDelegate)에서 environmentObject()를 사용하면 하위 뷰들은 어디서든 EnvironmentObject 어노테이션을 통해 값에 접근할 수 있다
부모로부터 자식뷰로마 전달되기 때문에 ContentTextView와 ContentButtonView 형제 뷰끼리 서로 값을 공유하지 않는다 
```swift
struct ContentView: View {
  var body: some View {
    VStack{
      ContentTextView()
      ContentButtonView()
    }
  }
}


struct ContentTextView: View {
  @EnvironmentObject var countRepo: CountRepo
  var body: some View {
    Text("\(self.countRepo.count)").font(.largeTitle)
  }
  
}

struct ContentButtonView: View {
  @EnvironmentObject var countRepo: CountRepo
  var body: some View {
    Button("숫자 증가") {
        self.countRepo.count += 1
      }
  }
  
}

```

### @Property Wrapper ?
Annotation을 활용하여 감싸져(Wrapping)있는 값을 사용하는 개념

**<랩핑된 wrapped value에 접근하기>**

```swift
@propertyWrapper
class WhateverDouble {
  private(set) var value: Int = 0 // propertyWrapper에서 WrappedValue는 반드시 구현해야 한다 
  
  // Whaterver의 get과 set을 처리
  var wrappedValue: Int {
    get { value }
    set { value = newValue * 2 }
  }
}

struct UserInfo {
  @WhateverDouble
  var age: Int
}

extension UserInfo {
  init(age: Int){
    self.age = age // age 할당과 동시에 WhateverDouble의 set에서 처리
  }  
}

var userInfo = UserInfo(age: 20)
print(userInfo.age) // 40, 값 호출과 동시에 Get에서 데이터를 가져옴
```
데이터는 propertyWrapper를 거치게 되며 엄밀히 말하는 age는 Int형이 아닌 PropertyWrapper의 wrappedValue로 감싸져있다.

**<propertyWrapper자체에 접근하기>**
$사인을 통해 propertyWrapper에 직접 접근하여 get, set을 거치지않고 값을 가져올 수 있다

```swift
@propertyWrapper
struct WhateverDouble {
  var value = 20
  var wrappedValue: Int {
    get { return value * 2 }
    set { value = newValue }
  }
  
  // 프로퍼티래퍼 자체를 변경하는 getter, setter
  // self는 WhateverDouble 자신
  var projectedValue: Self {
    get { return self }
    set { self = newValue }
  }
}

struct UserInfo {
  @WhateverDouble var age: Int
}

var userInfo = UserInfo()
userInfo.age = 10 
print(userInfo.age) // 실제값은 10이지만 wrappedValue를 거쳐 결과 20

// propertyWrapper를 직접 변경
// $사인을 통해 프로퍼티 값 자체에 접근할 수 있음
userInfo.$age = WhateverDouble()

print(userInfo.age) // 실제값은 20이지만 wrappedValue를 거쳐 40
print(userInfo.$age.value) // 실제값 20 출력

```








