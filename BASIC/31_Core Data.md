## Core data ?
Framework to Persist or cache data and support undo on a single device  
1. To saves your application's permanent data for offline us  
2. To caches temporary data  
3. To adds undo functionality to your app on a single device   

Core Data’s Data Model editor에서 데이터의 타입과 관계를 정의할 수 있고 각각 클래스르 정의할 수 있음  
그러면 Core data는 런타임 때 object 인스턴스를 관리함

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
