Rx나 Reactive를 사용하면 네트워크 통신에 유용. Combine도 마찬가지

더미 데이터를 활용하여 Combine 없이/ 있이 네트워크 통신을 어떻게 하는지 비교
https://jsonplaceholder.typicode.com/posts

## Combine없이
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

## Combine있이
