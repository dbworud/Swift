Rx나 Reactive를 사용하면 네트워크 통신에 유용. Combine도 마찬가지

더미 데이터를 활용하여 Combine 없이/ 있이 네트워크 통신을 어떻게 하는지 비교
https://jsonplaceholder.typicode.com/posts

## Combine 없이
```swift
enum HTTPError: LocalizedError {
  case statusCode
  case post
}

struct Post: Codable {
  let id: Int
  let title: String
  let body: String
  let userId: Int
}

let url = URL(string: https://jsonplaceholder.typicode.com/posts)

let task = URLSession.shared.dataTask(with: url){ data, response, error in

  // 에러 발생 시 분기처리
  if let error = error {
    fatalError("Error : \(error.localizedDescription)")
  }
  
  // 상태 코드의 분기처리
  guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    fatalError("Error: invalid HTTP response code")
  }
  
  // 데이터의 분기처리
  guard let data = data else {
    fatalError("Error: missing response data")
  }
  
  // JSON mapping
  do {
    let decoder = JSONDecoder()
    let posts = try decoder.decode([Post].self, from: data)
    print(posts.map {$0.title} )
  }
  catch {
    print("Error : \(error.localizedDescription)")
  }
}
task.resume()
```

## Combine 활용
```swift
enum HTTPError: LocalizedError {
  case statusCode
  case post
}

struct Post: Codable {
  let id: Int
  let title: String
  let body: String
  let userId: Int
}

let url = URL(string: https://jsonplaceholder.typicode.com/posts)

// dataTaskPublisher은 URLSession에서 제공하는 Publisher이다.
let cancellable = URLSession.shared.dataTaskPublisher(for: url)
  .map {$0.data}
  .decode(type: [Post].self, decoder: JSONDecoder()) // 전달받은 데이터를 JSON형식으로 decode
  .replaceError(with: []) // 에러가 발생할 경우 에러를 전달하지 않음
  .eraseToAnyPublisher()
  .sink (receiveValue: {posts in 
    print("전달받은 데이터는 총 \(posts.count)개 입니다")
  })

// 이후, cancellable.cancel()을 호출하여 스트림을 중단할 수 있음
```

## eraseToAnyPublisher ?
Publisher가 아닌 AnyPublisher형태로 리턴   
지금까지의 데이터 스트림이 어떠했던 최종적인 형태의 Publisher를 리턴

```swift
let x = PassthroughSubject<String, Never>()
  .flatMap { name in
    return Future<String, Error> { promise in
      promise(.success(""))
      }.catch {_ in
        Just("No User Found")
      }.map { result in 
        return "\(result) foo"
      }
     }
    }
  }

```
flatMap에 오버레이터를 사용하고 별도의 에러처리를 했기 때문에 Publishers.FlatMap<Publishers.Map<Publishers.Catch<Future<String, Error>, Just<String>>, String>, PassthroughSubject<String, Never>> 다음과 같은 형식으로 데이터를 받음
-> 타입이 너무 길고 개발자 입장에서 파이브라인이 어떤 흐름으로 연결되는지 외부에 노출됨

```swift
let x = PassthroughSubject<String, Never>()
///생략
}.eraseToAnyPublisher()
```
따라서, x는 AnyPublisher<String, Never>인 타입이 된다.


## ErrorHandling
.replaceError(with:[]) // 에러가 발생하면 에러스트림이 전달되지 않도록 처리

조금 더 상세한 에러처리를 위해
```swift
let cancellable = URLSession.shared.dataTaskPublisher(for: url)
  .tryMap{ data, response -> Data in // 성공해야만 데이터를 아래로 흘려보냄
  guard let httpResponse = response as? HTTPURLResponse, httpresponse.codeStatuse == 200 else {
    throw NetworkErrorType.invalidServiceResponse // 200이 아니면 호출
  }
  return data 
}

```
