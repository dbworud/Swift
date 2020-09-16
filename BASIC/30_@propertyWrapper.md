## @propertyWrapper
: 프로퍼티를 구현할 때 반복적으로 사용되는 패턴을 하드코딩하지 않고(ex. lazy, @NSCopying) 라이브러리로 구현해서 사용  
-> 컴파일러의 변경 최소화, more reusable 


#### 하드코딩 시, 필요할 때마다 반복적으로 코드를 작성해줘야 함 -> boilerplate code문제
```swift
struct Lazy {
    private var _foo: Int?
    
    var foo: Int {
        mutating get {
            if let value = _foo { return value }
            let initialValue = 1378
            _foo = initialValue
            return initialValue
        }
        set {
            _foo = newValue
        }
    }
}
```

#### @propertyWrapper 사용

```swift
@propertyWrapper
enum LazyWrap<Value> {
    case uninitialized(()-> Value)
    case initialized(Value)
    
    init(wrappedValue : @autoclosure @escaping () -> Value) {
        self = .uninitialized(wrappedValue)
    }
    
    var wrappedValue : Value {
        mutating get {
            switch self {
            case .uninitialized(let initializer):
                let value = initializer()
                self = .initialized(value)
                return value
            case .initialized(let value):
                return value
            }
        }
        set {
            self = .initialized(newValue)
        }
    }
}

@LazyWrap var foo : Int = 3000
```

foo 프로퍼티는 Int타입처럼 사용 가능하면서, LazyWrap을 통해 값에 접근
즉, 다음과 같이 바뀜
```swift
private var _foo : LazyWrap<Int> = LazyWrap<Int>(wrappedValue: 1738)

var foo: Int {
    get{
        return _foo.wrappedValue
    } set {
        _foo.wrappedValue = newValue
    }
}
```

### propertyWrapper 특징
* 자동으로 getter,setter생성하며, willSet, didSet 제공가능   
* (Requried) wrappedValue라는 인스턴스 프로퍼티 반드시 제공해야함 -> 여기에 계산 프로퍼티, 저장프로퍼티 모두 가능
* (Optional) projectedValue라는 프로퍼티 제공: propertyWrapperd의 값을 다른 타입으로 바꿔서 반환. '$'사용   
* 'property'Wrapper이기 때문에, Property가 아닌 다른 지역변수나 전역변수로 사용 불가

```swift
@propertyWrapper
struct WrapperWithProjection {
    var wrappedValue: Int
    var projectedValue : SomeProjection{
        return SomeProjection(wrapper: self)
    }
}

struct SomeProjection {
    var wrapper: WrapperWithProjection
}

struct SomeStruct {
    @WrapperWithProjection var x = 123
}

let s = SomeStruct()
s.x // Int
s.$x // Someprojection Value
s.$x.wrapper // WrapperWithProjection Value
```

### propertyWrapper의 초기화 여러가지 방법

```swift
@propertyWrapper
struct SomeWrapper {
    var wrappedValue : Int
    var someValue : Double
    
    init() {
        self.wrappedValue = 100
        self.someValue = 12.3
    }
    
    init(wrappedValue : Int){
        self.wrappedValue = wrappedValue
        self.someValue = 45.6
    }
    
    init(wrappedValue: Int, custom: Double){
        self.wrappedValue = wrappedValue
        self.someValue = custom
    }
}

struct SomeStruct {
    // init() 호출
    @SomeWrapper var a: Int
    
    // init(wrappedValue:) 호출. wrappedValue = 10
    @SomeWrapper var b = 10
    
    // init(wrappedValue:custome:)호출. wrappedValue = 30
    @SomeWrapper(custom: 78.9) var c = 30
    
    @SomeWrapper(wrappedValue: 30, custom: 98.7) var d
}
```

### propertyWrapper 합성
propertyWrapper를 2개 이상 적용 가능. 교환법칙은 성립하지 않으며, 합성 시 각 propertyWrapper의 제한 조건을 만족해야 함
```swift
// DelayMutable<Copying<UIBeizerPath>>
@DelayedMutable @Copying var path1: UIBeizerPath

// Copying<DelayedMutable<UIBeizerPath>>
@Copying @DelayedMutable var path2: UIBeizerPath
```

