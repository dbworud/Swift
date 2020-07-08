## Access Control
* restrict access to parts of your code from code in other source files and modules
* 클래스, 구조체, 열거형뿐만 아니라 프로퍼티, 메서드, initializer, subscript마다 특정 접근 수준을 부여가능 
* 전형적인 상황을 위한 default 접근 수준을 제공함으로써 명시적으로 표기하지 않아도 됨

## Modules & Source Files
접근수준은 modules 와 source files 컨셉에 기반

**module** : single unit of code distribution that can be imported by another module with 'import' keyword. ex. framework, application
**source file** : single Swift source code file within a module.

## Five Access Levels

### Open access and public access
* 같은 module에 속한 어느 source file 내에서 사용 가능
* 정의된 module을 import한 다른 module에 속한 어느 source file 내에서 사용 가능
* 일반적으로 framework에 공용 인터페이스를 지정할 때 open 또는 public 접근 사용
* highest access level (= least restrictive)
* **open access** : 오로지 클래스와 클래스 멤버들에만 적용됨.  
      open class는 정의된 모듈 내에서 서브 클래싱 될 수 있으며 정의된 모듈을 가져오는 모듈 내에서 서브클래싱 될 수 있음  
      open class멤버는 정의된 모듈 내의 하위 클래스와 정의된 모듈을 가져오는 모든 모듈에서 overrid될 수 있음
* **public access** : public접근 또는 더 제한적인 접근 수준이 있는 클래스는 정의된 모듈 내에서만 서브 클래싱 할 수 있음  
                public접근 권한이 있는 클래스 멤버 또는 제한적인 접근 수준은 정의된 모듈 내에서만 하위클래스에 의해 override 될 수 있음
                
                    


### Internal access
* 같은 module에 속한 어느 source file 내에서 사용 가능
* 정의된 module을 import한 다른 module에 속한 어느 source file 내에서 사용 X 
* 일반적으로 app이나 framework의 내부 구조를 정의할 때 

### File-private access
* 같은 source file내에 entity 사용을 제한
* 세부 정보가 전체 파일 내에서 사용될 때 특정 함수의 구현 세부 정보 숨기기 위해 

### Private access
* enclosing 선언이나 같은 파일 내에 선언의 extension으로 entity 사용을 제한
* 세부 정보가 오직 하나의 선언 내에서 사용 될 때 특정 함수의 구현 정보를 숨기기 위해
* lowest access level (most restrictive)

### Access Level의 원칙
* *No entity can be defined in terms of another entity that has a lower (more restrictive) access level.*
ex1. public 변수는 internal, file-private, private타입으로 정의될 수 없다.  
ex2. 함수는 그들의 매개변수나 return 타입보다 높은 접근수준을 지닐 수 없다. 

### Single-Target App을 위한 Access Level
* 앱에 있는 코드는 일반적으로 앱 내에 self-contained되어 app module 밖에서 실행가능하도록 만들 필요가 없음
* 이미 default는 internal

### Frameworks 위한 Access Level
* framework를 개발할 시, public-facing interface 를 open이나 public으로 하여 다른 module에서 보고 접근 가능하도록
ex. API for the framework

### Unit Test Targets 위한 Access Level
* default로 오직 open 혹은 public인 entity만 다른 모듈에 접근할 수 있음.
* 그러나, unit test target은 어떠한 internal entity를 접근할 수 있어야 함. @testable 에 의해 선언을 import했다면.

### Access Control Syntax
```swift
public class SomePublicClass {}
internal class SomeInternalClass {}
file-private class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
file-private func someFilePrivateFunction() {}
private func somePrivateFunction() {}

```
