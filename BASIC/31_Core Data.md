## Core data ?
Framework to Persist or cache data and support undo on a single device, not Database!!
넓은 의미로 앱의 모델 계층, 객체 그래프를 관리하는 framework
1. To saves your application's __permanent__ data for offline us  
2. To caches temporary data  
3. To adds undo functionality to your app on a single device   

Core Data’s Data Model editor에서 데이터의 타입과 관계를 정의할 수 있고 각각 클래스르 정의할 수 있음  
그러면 Core data는 런타임 때 object 인스턴스를 관리함
UserDefaults는 app setting과 같은 간단한 정보를 저장하기에 적합, Core data는 복잡하고 큰 user data를 저장하기에 적합

### 1. Persistance
abstract the details of mapping your objects to store without administrating database directly 

### 2. Undo and Redo of individual or batched(한 번에 일괄처리하는) changes 
track changes and can roll them back individually ,in groups, or all at once 

### 3. Background Data Tasks
perform potentially UI-blocking data tasks(ex. parsing JSON into objects), in the background  
-> You can cache or store the results to reduce server roundtrips

### 4. View Synchronization
helps keep your views and data synchronized by providing data sources for table and collection views

### 5. Versioning and Migration 
include mechanisms for versioning your data model and migrating user data as your app evolves 

### Why it's good ?
Codable and UserDefaults, but it’s much more advanced than that: Core Data is capable of sorting and filtering of our data, and can work with much larger data – there’s effectively no limit to how much data it can store. Even better, Core Data implements all sorts of more advanced functionality for when you really need to lean on it: data validation, lazy loading of data, undo and redo, and much more.

### It Requires and already done for us
1. create what' called 'persistent container'(which is what loads and saves the actual data from device storage)
2. inject that into SwiftUI environment so that all our views can access it   
우리는 core data에 어떤 것을 저장할지, 어떻게 다시 읽어들일지를 정하면 됨

Core data는 struct 나 class와 달리, 우리의 데이터 타입이 어떻게 생겼는지, 무엇을 포함하는지, 이들의 관계는 어떤지 미리!! 알고있어야함   
"entities": data types, "attributes": properties in there   
And then, Core data converts that into an actual database layout it can work with at runtime! 

### @FetchRequest
retrieve information from Core Data and we have to make sure that this fetch request stays up to date over time, so UI synchronized   
Requried two properties 1. the entity we want to query, 2. how we want the results to be sorted 

### @Environment
To add and save objects, we need access to the managed object context that it's in SwiftUI's environment.  
we can ask it for the current managed object context, and assign it to a property for our use


### In-Memory 방식
중앙집중적인 NSManagedObjectContext가 NSManagedObject의 인스턴스를 다루기 위해 NSManagedObject포인터에게 메세지를 보내는 방식
- 처리속도를 위해 인메모리 형식 사용. 디스크에 영속적으로 저장될 필요 없이 임시 내용을 담는 객체가 필요한 경우, 데이터베이스에 비해 코어데이터가 훨씬 빠른속도로 객체를 생성/수정/조작이 가능.  
- 메모리 상의 객체를 수정하는 것만 가능  
- 코어데이터는 데이터들을 메모리에 로딩하는 과정 없이는 작업이 불가능하다  
- 코어데이터는 데이터 로직을 다루지는 않는다. SQLite에서의 데이터제약인 unique key같은 기능이 Core data에서는 없다

<img width="634" alt="DBvsCoreData" src="https://user-images.githubusercontent.com/59492694/94983757-d60c1180-0580-11eb-8138-f4babc88385a.png">

