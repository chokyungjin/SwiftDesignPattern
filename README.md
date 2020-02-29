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

> [weak self]

#### [weak self]

* self 사용시 retain count를 증가시키게 되는데 closure가 self를 해제하여 retain count를 낮춰준다면 문제없지만, 다른 클래스 프로퍼티에 붙잡혀 있다면 문제가 발생
* closure는 self가 해제 될 때까지, self는 closure가 해제될 때까지 기다리는 강한 참조 cycle 상황을 만듦.
* closure의 선언부에 `[weak self] param in`을 명시해주고 self가 사용되는 곳에 self를 **optional**로 사용해주면 strong reference cycle 상황을 피해 갈 수 있게 된다. 
* strong reference cycle이 발생하는지 사전에 알기 어렵기 때문에 만약 closure 내부에서 self를 사용하게 된다면 `[weak self] param in`을 항상 먼저 명시해주는 습관을 기르면 더 좋지 않을까 싶다.

```swift
disposable = producer.startWithNext { [weak self] number in 
                                     self?.total += number 
                                     print(self?.total) 
                                    }
```

> Equatable

* 구조체 , 클래스, enum 타입끼리 비교가 힘들 때, 채택하여 서로 비교하게 만들어줌!
* 대신 ==연산자를 재정의 해줘야함.

> Clean Architecture

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

> Core Data

iOS에서 DB를 조금 더 손쉽게 사용할 수 있도록 하는 방법

SQLite를 직접적으로 사용하지 않은 상태에서 접근 가능하게 해준다.

코어 데이터를 iOS의 또 다른 데이터베이스로 생각할 수 있지만 코어 데이터는 DB가 아니다.

##### xcdatamodeld - 코어 데이터에서 엔티티 설계를 할 수 있는 파일

코어 데이터 사용 옵션을 체크하면 AppDelegate.swift 에 다음과 같은 코어 데이트 구문이 추가된다.

```	swift
lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CleanStorePractice")
  //이 부분은 xcdatamodeld 파일을 코어 데이터 시스템에 등록하고 NSPersistentContainer 객체를 생성하는 역할을 하는데 xcdatamodeld 파일명을 변경하려고 할 때 위의 구문도 파일명과 동일하게 변경해야 한다.

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
// MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
      //이 부분은 코어 데이터에서 데이터를 읽고 쓰기 위해 사용하는 컨텍스트 객체를persistentContainer.viewContext 속성을 통해 참조한다.
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
```

let context = persistentContainer.viewContext 이 구문으로 반환되는 값은 NSManagedObjectContext 객체이다.

관리 객체 컨텍스트라고 하며 코어 데이터에서 데이터를 저장하기 위해 사용되는 인스턴스인 관리 객체를 담고 생성하고 삭제하는 기능을 담당한다.

관리 객체는 데이터베이스에서 테이블의 행이나 레코드에 해당한다. 레코드를 구성하는 각 칼럼은 관리 객체의 속성이 된다.

모든 관리 객체는 컨텍스트에 담겨 관리되며 컨텍스트를 통해 새로운 관리 객체를 생성하거나 기존 관리 객체를 삭제할 수 있다.

컨텍스트에 담긴 모든 관리 객체를 영구 저장소로 보내어 저장할 수도 있다.

#### NSPersistentStore (영구 저장소)

데이터를 저장하는 파일을 나타낸다.

앱에서 코어데이터를 이용하도록 설정할 때 영구 저장소의 이름, 위치, 타입을 지정해야 한다.

#### NSPersistentStoreCoordinator (영구 저장소 관리자)

객체의 데이터를 실제로 저장하고 있는 실제 파일과 앱이 사용하는 객체 모델 사이를 중개한다.

앱은 NSPersistentStoreCoordinator에 직접 접근할 일이 거의 없다.

단지 코어 데이터 실행 환경을 구성할 때 관리자 객체를 생성만 해주면 된다.

NSPersistentStoreCoordinator 는 하나 이상의 영구 저장소와의 통신을 관리하기 때문에 데이터가 어떻게 저장되는지를 앱으로부터 감춘다.

#### NSManagedObjectContext (관리 객체 컨텍스트)

관리 객체가 존재하는 영역.

앱에서는 관리 객체의 생성, 삭제, 편집, 질의 등을 수행하기 위해 NSManagedObjectContext와 통신한다.

NSManagedObjectContext는 객체들의 변경사항을 관리하며 모든 변경사항을 한꺼번에 저장하거나 경우에 따라서는 rollback 한다.

전체 데이터 작업을 분리하거나 제한하기 위해 하나 이상의 context를 동시에 사용할 수 있다.

#### NSManagedObjectModel (관리 객체 모델)

관리 객체는 관리 객체 모델 (NSManagedObjectModel) 에서 정의한다.

NSManagedObjectModel은 개체(Entity)의 리스트, 각 개체와 연결된 속성 리스트(properties), 각 개체 및 속성과 연결된 유효성 검증, 개체 간의 관계를 포함한다.

관리 객체 모델은 주로 Xcode의 데이터 모델 편집기를 이용해 생성한다.

#### NSManagedObject (관리 객체)

코어 데이터 상에서 실제 정보를 담고있는 객체를 의미한다.

관리 객체를 키와 그 키에 대응하는 타입의 객체를 가진 Dictonary 객체처럼 생각할 수 있다.

<img width="650" alt="스크린샷 2020-02-28 오후 5 06 46" src="https://user-images.githubusercontent.com/46750574/75522230-d6718680-5a4c-11ea-922f-48b5f27b7b6e.png">















