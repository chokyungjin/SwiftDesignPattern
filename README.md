# SwiftDesignPattern

---

## Clean Swift

> Clean swift는 프레임워크가 아닌 템플릿으로 V.I.P 패턴을 쉽게 사용하게 만들어주는 템플릿

* VIP: VIew, Interactor , Presenter
* View : 뷰
* Interactor : 비즈니스 로직
* Presenter : UI를 위한 데이터 가공

ViewController - Interactor - Presenter 사이클로 이루어져 있으며, ViewController 에서 버튼 클릭, 데이터 파싱 등의 요청이 발생하면 Interactor에서 그 부분을 처리하고 Presenter에서 그 결과를 화면에 그려줄 수 있도록 마지막 포맷팅 작업을 해준다.

![스크린샷 2020-02-18 오후 2.19.05](/Users/chokyungjin/Desktop/스크린샷 2020-02-18 오후 2.19.05.png)

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

![스크린샷 2020-02-17 오후 7.27.23](/Users/chokyungjin/Desktop/스크린샷 2020-02-17 오후 7.27.23.png)

* 템플릿 설치 이후에 New File을 스크롤 하면 Clean Swift영역에 Scene 이용하여 파일 생성할 수 있다.

![스크린샷 2020-02-17 오후 9.33.47](/Users/chokyungjin/Desktop/스크린샷 2020-02-17 오후 9.33.47.png)

* VIP에서는 앱 개발시 필요한 로직을 여러개로 나누어서 처리함.

1. 화면에 뷰를 표시하는 Display Logic
2. 데이터 처리, 네트워크 처리 등을 담당하는 Business Logic
3. Business Logic에서 얻어온 데이터를 View Model로 변환해주는 Presentation Logic
4. ViewController간의 화면 전환 및 데이터 전달을 위한 Routing( Navigation, Data Passing) Logic (e.g. present, dismiss, push, pop)

* Scene은 화면 단위로 컴포넌트들을 구분시킨다.

![스크린샷 2020-02-18 오후 2.19.50](/Users/chokyungjin/Desktop/스크린샷 2020-02-18 오후 2.19.50.png)

---

## Have To

* Clean Store 예제



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