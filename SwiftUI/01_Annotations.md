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


## @EnvironmentObject ?
