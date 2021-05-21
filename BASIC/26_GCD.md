### 멀티스레딩을 위한 API
* GCD(Grand Central Dispatch): C 기반의 저수준 api, 부담없이 사용 가능 
* NSOperation: Objective-C 기반 고수준 api, 약간의 오버헤드 발생하여 느리지만 GCD가 해야하는 작업들을 지원(ex. KVO관찰, 작업취소)

## GCD의 DispatchQueue ?
실제로 해야 할 task를 담아두면 선택된 스레드에서 실행을 해주는 역할

앱 실행시, 시스템에서 기본적으로 **Main Queue** 와 **Global Queue**를 만들어줌   
* Main Queue : 메인 스레드(=UI 스레드)에서 사용되는 serial queue. 모든 UI처리는 메인 스레드에서 처리     
(Serial DispatchQueue : 등록된 작업을 한 번에 하나씩 차례대로 처리. 작업이 완료되면 순차적으로 다음 작업 실행)   

* Global Queue : 편의상 사용할 수 있게 만들어놓음. 처리우선을 위해 필요한 qos(Quality Of Service) 파라미터 제공     
(Concurrent DispatchQueue : 여러 작업들을 동시에 처리)     
qos 우선순위: userInteractive > userInitiated > default > utility > background > unspecified    

## DispatchQueue의 메소드

### 1.sync 동기처리 메소드
```swift
DispatchQueue.main.sync {
  print("value : 1")
}
print("value : 2") 

----------
value : 1
value : 2
```

### 2. async 비동기처리 메소드
단순히 처리하라고 지시한 후 넘어감
보통 스레드 처리를 하느 작업들은 시간이 꽤 걸리기 때문에 (ex. 네트워크, 파일로딩) async로 작업의 효율성

```swift
let globalQueue = DispatchQueue.global(qos : .background)
globalQueue.async {
  print("value : 1")
}
print("value : 2")

----------
value : 2
value : 1
```

Serial/Concurrent와 async/syncs는 별개      
Serial/Concurrent는 한 번에 하나만 처리할지, 동시에 여러개를 처리할 지     
sync/async는 처리가 끝날 때까지 기다리는지, 지시만 하고 넘어가는 지     

### 메인 스레드에서 DispatchQueue.main.sync하면 안되는 이유?

메인 스레드에서 sync를 호출한다면, 메인 스레드 뿐만 아니라 작업이 완료되기를 기다리는 queue까지 block  
-> 작업이 절대 끝나지 않음 = deadlock.    
즉, Sync 함수 특성상 main queue에 넣은 작업이 완료되기 전까지 메인 스레드는 blocking waiting 상태  
그런데 이 작업은 메인 스레드에서 serial하게 실행되는 main queue에 들어가 있으므로 UI는 영영 업데이트 되지 않는다. 
만약 작업이 실패하더라도 UI가 끊기는 일이 없도록 해야한다 

즉, 메인 스레드는 async + serial로 처리됨  
global 스레드는 concurrent    

### 언제 Sync 사용?   
-  작업이 끝나는 것을 기다려야 할 때
-  함수나 메소드가 중복으로 불리지 않게 해야할 때 
-  동기화 작업을 진행하는 도중 이 동기화 작업을 중복으로 시도하지 않기 위해    
