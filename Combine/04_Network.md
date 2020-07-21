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
Publisher가 아닌 AnyPublisher
