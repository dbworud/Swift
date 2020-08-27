## Codable (protocol)

Codable = Encodable + Decodable     
* Encodable : data를 encoder에서 변환해주려는 프로토콜로 바꿔줌. ex.model을 json으로 인코드     
* Decodable : data를 원하는 모델로 decode해줌. ex. json을 내가 원하는 model로 디코드    

**struct, enum, class** 전부 채택 가능   

User 라는 구조체가 Encodable, Decodable 프로토콜을 채택하는 경우
```swift
struct User {
  let id: Int
  let name: String
  let birth: String
  let phoneNum: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case birth
    case phoneNum = "phone_num"
  }
}
```

## Decodable (protocol)
Decodable을 채택하면 **무조건 init 생성**

```swift
extension User: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy : CodingKeys.self)
    
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    birth = try container.decode(String.self, forKey: .birth)
    phoneNum = try container.decode(String.self, forKey: .phoneNum)
  }
}

func decode() {
 let jsonString = """
                       [
                            {
                                "id": 1,
                                "name": "shark1",
                                "birth": "1999-03-17",
                                "phone_num": "010-2222-3333"
                            },
                            {
                                "id": 2,
                                "name": "shark2",
                                "birth": "1999-03-19",
                                "phone_num": "010-2222-3334"
                            },
                            {
                                "id": 3,
                                "name": "shark3",
                                "birth": "1999-03-20",
                                "phone_num": "010-2222-3353"
                            }
                        ]
                      """

  let jsonData = jsonString.data(using: .utf8) // decode하기 위해서는 Data타입이 필요하므로 String->Data로 변환
  
  do {
    guard let jsonData = jsonData else { return }
    let dataModel = try JSONDecoder().decode([User].self, from: jsonData) // JSONDecoder()을 이용하여 decoder를 [User]타입에 맞게!
    print(dataModel)
  } catch let error {
    print("Error : \(error)")
  }
}

// result: User형태에 맞게 decode(JSON -> 'User' model)
[Codable.User(id: 1, name: "shark1", birth: "1999-03-17", phoneNum: "010-2222-3333"), 
 Codable.User(id: 2, name: "shark2", birth: "1999-03-19", phoneNum: "010-2222-3334"), 
 Codable.User(id: 3, name: "shark3", birth: "1999-03-20", phoneNum: "010-2222-3353")]
```

## Encodable (protocol)

```swift
extension User: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encoder(id, forKey: .id)
    try container.encoder(name, forKey: .name)
    try container.encoder(birth, forKey: .birth)
    try container.encoder(phoneNum, forKey: .phoneNum)
  }
} 

func encode() {
  // decode와는 반대로, userObject라는 객체 생성
  let userObject = User(id: 1, name: "shark1", birth: "2000-03-02", phoneNum: "010-3434-2222")
  
  do {
    let jsonData = try JSONEncoder().encode(userObject) // JSONEncoder의 encode매서드를 이용하여 Data타입으로 만든다
    let jsonString = String(data: jsonData, encoding: utf8) // String타입으로 만든다
    guard let printJSONString = jsonString else { return }
    print(printJSONString)
  } catch let error {
    print("Error : \(error)")  
  }
}

// result
{"id":1,"name":"shark1","birth":"2000-03-02","phone_num":"010-3434-2222"}

```
