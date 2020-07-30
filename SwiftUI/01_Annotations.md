## @State ?
### SwiftUI가 자동으로 변경사항을 observe하여 해당 state부분을 view에 업데이트

* swiftUI에서는 state로 선언한 모든 프로퍼티의 스토리지를 관리
* state 값이 변경되면 view의 apperance를 invalidates하고 body를 다시 계산
* state 인스턴스는 value자체가 아니며 *값을 읽고 변경하는 수단*. state의 값에 접근하려면 var을 사용해야 함
* view의 body에서만 state프로퍼티에 접근하게 하기 위해 private로 선언
* state 값을 바인딩하기 위해 $연산자 사용

```swift
struct Picker: View {

  var body: some View {
    Picker("", selection: .constant(0)){
      Text("A").tag(0)
      Text("B").tag(1)
      Text("C").tag(2)
    }.pickerStyle(SegmentedStyle())
  }
}

struct Picker: View {

  @State private selectedIndex = 0
  var body: some View { 
    Picker("", selection: $selectedIndex){
      Text("A").tag(0)
      Text("B").tag(1)
      Text("C").tag(2)
    }.pickerStyle(SegmentedStyle())
  }
}
```

 
## @ObservedObject ? 
### @State보다 더 복잡한 상황에서 값의 변화를 인지하여 view에 업데이트

* @State는 특정 view에서만 사용했다면, @ObservedObject는 더 복잡한 프로퍼티(여러 프로퍼티나 메소드가 있거나, 여러 view에서 공유할 수 있는 커스텀 타입이 있는 경우)대신 사용. 
* string이나 integer같은 간단하 프로퍼티 대신 외부참조타입(external reference type)을 사용. 
* @ObservedObject와 함께 사용하는 타입은 ObservableObject 프로토콜을 따라야함. 
* @ObservedObject의 값이 변했음을 뷰에 알리기 위해 @Published라는 프로퍼티 래퍼를 사용. 

```swift
class UserSettings: ObservableObject {
  @Published var score = 0
}

struct ContentView: View {
  @ObservedObject var settings = UserSettings()
  
  var body: some View {
    VStack {
      Text("Your score is \(settings.score)")
      Button (action : { self.settings.score + = 1}){
        Text("increase the score")
      }
    }
  }
}
```

## @EnvironmentObject ?
### 모든 view가 shared할 수 있는 data

* 반드시 enviromentObject(_ :)메소드를 호출하여 상위 뷰에서 모데 객체를 설정해야한다. SceneDelegate에서 설정 필요
* 앱의 어느 곳에서나 접근 가능
* 실행방식: 해당 type의 object를 찾기위해 환경을 훑고 그것을 해당 프로퍼티에 attach함

```swift 
let content = ContentView().environmentObject(settings)

struct UserSettings: ObservableObject {

  @EnviromentObejct var settings: UserSettings
  
}

struct ZeddView: View {

  @Environment var settings: UserSettings
  
  var body: some View {
    Text("\(settings.score)")
  }
}

```

## @Environment ?
### 이미 정의된 key들로 작업하기 위해 있는 것
(@EnviromentObjects는 특정 환경에 값들을 주입시키는 역할)

* Core data, 다크모드/라이트모드인지, 렌더링하는 화면의 크기가 몇인지, 더 고정된 프로퍼티를 읽는데 유용  
* 해당 변수가 바뀌면 읽어들임

```swift
@Environment(\.horizontalSizeClass) horizontalSizeClass
@Environment(\.managedObjectContext) managedObjectContext
```

```swift
struct ButtonView: View {
  @Envrionment(\.sizeCategory) var sizeCategory

  var body: some View {
    Group {
       if sizeCategory == .accessibilityExtraExtraExtraLarge {
          VStack { buttons } 
       else {
            HStack { buttons }
          }
       }
    }
  }
}

struct ModalView: View {
  @Environment(\.presentationMode) var presentation
  
  var body: some View {
    Button("dismiss") {
      self.presentation.value.dismiss()    
    }
  }
}

```

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion
@Environment(\.accessibilityReduceTransparency) var reduceTransparency
@Environment(\.accessibilityEnabled) var accessibilityEnabled
```
해당 변수들은 같은 data type을 사용하고 있으며, boolean을 반환하기 때문에 어떤 key를 읽는지 명확히 해야한다.  





