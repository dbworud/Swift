## URLSession ?
API로 서버와의 데이터 교류. HTTP를 포함한 몇 가지 프로토콜 지원, 인증, 쿠키관리, 캐시관리 등을 지원
기본 구조인 **Request** 와 **Response** 가 있으며   
**Request**는 1. url 객체를 통해 직접 통신하는 형태, 2.URLRequest 객체를 만들어서 옵션을 설정하여 통신하는 형태
**Response**는 

1. 설정된 task의 Completion handler형태로 response를 받거나, 
-> 일반적으로 간단한 response를 작성  

2. URLSessionDelegate를 통해 지정된 메소드를 호출하는 형태로 response를 받음  
-> 앱이 background상태로 돌아갈 때에도 파일 다운로드르 지원하도록 설정하거나, 인증과 캐싱을 default로 사용하지 않는 상황에서 사용   

## URLSessoin의 LifeCycle
1. Session configuration을 결정하고, Session을 생성한다  
2. 통신할 URL와 Request 객체를 설정한다  
3. 사용할 Task 결정하고, 그에 맞는 Completion handler나 Delegate 메소드를 작성
4. 해당 Task 실행
5. Task완료 후, Completion handler가 실행됨   



