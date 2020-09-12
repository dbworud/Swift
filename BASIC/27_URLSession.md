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

## URLSessoin의 Session

1. default: 기본적인 session. 디스크 기반 캐싱 지원 (caching: 컴퓨터 과학에서 데이터나 값을 미리 복사해놓고 접근시간을 단축시킴)
2. ephemeral: 어떠한 데이터도 저장하지 않는 세션
3. background: 앱이 종료된 이후에 통신이 이루어지는 것을 지원하는 세션

## URLSessoin의 Request

: 서버로 요청을 보낼 때, 어떻게 데이터를 캐싱할 것인지, 어떤 HTTP메소드(get, post, put 등)을 사용할 것인지,
 어떤 내용을 전송할 것인지 설정

## URLSessoin의 Task

 : Session객체가 서버로 요청을 보낸 후, 응답을 받을 때 URL기반의 내용들을 받는(retrieve) 역할을 함. 3가지 종류의 task가 지원
 
 1. Data Task: 데이터 객체를 통해 데이터를 주고 받는 작업
 2. Download Task: 데이터 -> 파일 형태로 전환 후 다운로드하는 작업. 백그라운드 다운로드 지원
 3. Upload Task: 데이터 -> 파일 형태로 전환 후 업로드하는 작업



URLSession과 같은 네트워킹용 API는 일반적으로 앱 전역에서 사용됩니다. 그렇기 때문에 ViewController에 메소드를 작성하기보다는 하나의 모듈(class)을 만들고 그 안에 static 함수들을 만들어 사용하는 것이 좋습니다.
