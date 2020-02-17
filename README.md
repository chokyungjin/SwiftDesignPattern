# SwiftDesignPattern

---

## Clean Swift

> Clean swift는 프레임워크가 아닌 템플릿으로 V.I.P 패턴을 쉽게 사용하게 만들어주는 템플릿

* VIP: VIew, Interactor , Presenter
* View : 뷰
* interactor : 비즈니스 로직
* Presenter : UI를 위한 데이터 가공

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

