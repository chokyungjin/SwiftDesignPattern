# Swift DesignPattern

---

## Clean Swift

> Clean swift는 프레임워크가 아닌 템플릿으로 V.I.P 패턴을 쉽게 사용하게 만들어주는 템플릿

* VIP: VIew, Interactor , Presenter
* View : 뷰
* Interactor : 비즈니스 로직
* Presenter : UI를 위한 데이터 가공

ViewController - Interactor - Presenter 사이클로 이루어져 있으며, ViewController 에서 버튼 클릭, 데이터 파싱 등의 요청이 발생하면 Interactor에서 그 부분을 처리하고 Presenter에서 그 결과를 화면에 그려줄 수 있도록 마지막 포맷팅 작업을 해준다.

<img width="700" alt="스크린샷 2020-02-23 오후 3 11 57" src="https://user-images.githubusercontent.com/46750574/75104655-29af9780-564f-11ea-9a4e-61fdab066a64.png">

### Models 

컨트롤러와 관련된 모든 모델을 저장.

* Request - API request에 보내지는데 필요한 파라미터
* Response - API로부터 response를 intercept 하고 데이터를 저장
* ViewModel - UI에 관련된 모든 것을 저장

### Worker  

API/CoreData 요청 및 응답을 관리. Interactor에게 줄 데이터를 준비

### Interactor 

Worker 와 Presneter 사이의 중개자.

VC -Model (request) -Interactor -Worker -Model (response) -interactor -presenter 와 같은 흐름!

### Presenter 

Interactor로 부터 받은 데이터를 ViewModel에 맞게 정형화하고 뷰컨트롤러에 전송한다. 즉 사용자에게 데이터를 어떻게 보여질지 결정

### Router 

뷰컨트롤러 사이에서 데이터 transition과 passing을 관리

<img width="700" alt="스크린샷 2020-02-23 오후 3 12 06" src="https://user-images.githubusercontent.com/46750574/75104657-2caa8800-564f-11ea-829d-cbe4b88ec375.png">

* 템플릿 설치 이후에 New File을 스크롤 하면 Clean Swift영역에 Scene 이용하여 파일 생성할 수 있다.

* VIP에서는 앱 개발시 필요한 로직을 여러개로 나누어서 처리함.

1. 화면에 뷰를 표시하는 Display Logic
2. 데이터 처리, 네트워크 처리 등을 담당하는 Business Logic
3. Business Logic에서 얻어온 데이터를 View Model로 변환해주는 Presentation Logic
4. ViewController간의 화면 전환 및 데이터 전달을 위한 Routing( Navigation, Data Passing) Logic (e.g. present, dismiss, push, pop)

* Scene은 화면 단위로 컴포넌트들을 구분시킨다.

<img width="700" alt="스크린샷 2020-02-23 오후 3 13 21" src="https://user-images.githubusercontent.com/46750574/75104658-2e744b80-564f-11ea-8d0b-e0d67ad06af3.png">

---

## Have To

* Clean Store 예제 (코드 리뷰 중)
* iOSCleanArchitecture-TodoList 예제

---

## Study

> inout

함수가 호출되고 종료될 때, 함수 내부에서 변경된 값은 함수 외부의 값에는 영향을 끼칠 수 없다. 하지만 함수 호출이 종료된 후에도 변경 사항을 유지해야할 경우, inout 파라미터를 사용 -> 참조 연산자라고 생각하자

> init(nibName nibNameOrNil:, bundle:)

`init(nibName:bundle:)` 은 nib 파일로부터 뷰 컨트롤러를 생성할 때 사용하며, 이 때 nib 파일은 아직 로딩되지 않는다.

`UIViewController`들은 `init(nibName:bundle:)`이라는 초기화 메소드를 지원한다. 실질적으로 이 과정은 뷰 컨트롤러 (혹은 AppKit에서의 윈도 컨트롤러)인스턴스를 초기화하고, 여기에 `nibName` 속성을 부여한다.

 그리고 nib 파일은 실질적으로는 게으르게 평가되면서 뷰를 실제로 액세스하기 위해서 로드하는 시점에 읽어들이게 된다.
nib 파일을 읽어들이는 과정은 파일로부터 직렬화된 데이터를 읽고 이를 객체 그래프로 복원하는 과정이다. 

이 과정에서 얼려져있던 객체들이 온전한 인스턴스로 복원되며, 이를 위해서 모든 객체들은 `init(coder:)` 메시지를 받게 된다.

---

1. Clean Architecture

유지보수 및 테스트하기 용이한 코드를 작성하기 위해 고안된 아키텍쳐. 크게 4개의 layer로 구성

* Infra (Framework & Drivers)
* Interface (Interface Adapters)
* App (Application Business Rules)
* Domain (Enterprise Business Rules)

각 sw 계층은 독립적이며 각기 다른 영역을 나타내고 있다. 바깥으로 향할수록 고수준의 sw, 바깥쪽은 원의 메커니즘이고 안쪽은 원의 정책이다. 의존 규칙에 의하여 소스코드는 안쪽을 향해서만 의존할 수 있다. 안쪽 원은 바깥쪽의 원에 대해 전혀 알지 못하며 안쪽원에서 바깥 쪽의 어느 이름도 참조해서는 안된다. 의존성 주입에 의해 바깥쪽에서 안쪽으로만 이루어진다.

#### Infra

Clean architecture의 가장 바깥쪽 레이어로, 공통적으로 쓰이는 서비스나 외부 인터페이스 등을 관리하는 곳이다. 보안/인증 설정이나 DB 설정 등의 내용이 들어가면 좋을 것 같다. 

#### Interface

바깥과 통신하는 request/response와 내부 데이터 접근 layer 사이에 위치하는 layer이다. 흔히 MVC 구조에서
Controller가 이 layer에 위치하며, interface layer는 business logic만을 관장하고 실제 데이터에 접근하고 조작하는 작업에 대한 권한은 application layer에 위임한다. 

#### App

필요한 데이터와 repository를 interface로부터 주입받아 데이터를 조작하고 처리하는 layer이다. 앱 고유 비즈니스 규칙을 포함하여 시스템의 모든 유스케이스를 캡슐화하고 구현

#### Domain

Domain layer는 실제 DB에 담기는 데이터의 model과 1대1로 mapping되는 entity 객체를 담는 곳이다. 엔티티는 사용자가 실제로 생각하는 개념의 단위



