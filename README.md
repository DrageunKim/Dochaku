# 📍 도차쿠 📍

## 🗒︎ 목차

1. [소개](#-소개)
2. [개발환경 및 라이브러리](#-개발환경-및-라이브러리)
3. [팀구성](#-팀구성)
4. [타임라인](#-타임라인)
5. [파일구조](#-파일구조)
6. [실행화면](#-실행-화면)
7. [트러블 슈팅 및 고민](#-트러블-슈팅-및-고민)
8. [출시심사 리젝](#-출시심사-리젝)
9. [회상](#-회상)

<br>

## 👋 소개

**목적지를 설정한 후 사용자 위치가 목적지에 근접하면, 푸쉬알림을 통해 사용자에게 알림을 보내주는 앱입니다.**

- 프로젝트 기간 : 23.02.23 ~ 23.04.06 (6주)

**[다뤄본 기술]**

- MVVM
- RxSwift
- Network - URL Session (GET)
  - Open API - [Odsay] Public Transit Poi
- MapKit
- CoreLocation
- UserNotifications
- CoreData
- Code단으로 Layout 구성

## 💻 개발환경 및 라이브러리

[![swift](https://img.shields.io/badge/swift-5.6-orange)]()
[![macOS](https://img.shields.io/badge/macOS_Deployment_Target-14.0-blue)]()

<br>

## 🧑 팀구성

|                            Dragon                            |
| :----------------------------------------------------------: |
| <img src = "https://i.imgur.com/LI25l3O.png" width=200 height=200> |

<br>

## 🕖 타임라인

| 날짜     | 구현 내용                                                    |
| -------- | ------------------------------------------------------------ |
| 23.02.23 | TapBar 추가<br />MainViewController 구현<br />Network 기본 구조 설계 |
| 23.03.01 | Extension - JSONDecode 기능 추가<br />RealTimeStationArrival 모델 생성 |
| 23.03.05 | Subway & BusViewController UI 구현                           |
| 23.03.06 | Subway & BusViewController UI 조정                           |
| 23.03.08 | Network 설계 보완 및 구현<br />RealTimeArrival 동작 확인<br />경로검색 API 변경 (서울 열린데이터광장-> Odsay)<br />API 변경으로 인해, DTO & Network & UnitTest 코드 변경 |
| 23.03.10 | SubwayViewModel 생성 및 데이터 Binding 구현                  |
| 23.03.13 | ListViewController UI 구현                                   |
| 23.03.14 | API를 통해 위도, 경도 데이터 추출하는 기능 구현              |
| 23.03.15 | SearchBar에서 지하철역 검색 후 위도, 경도 데이터 추출하는 기능 구현 |
| 23.03.16 | 지하철역 검색하여 지하철역코드가 있을 경우에 TableViewCell에 표시되도록 구현<br />Local Push (Timer방식) 기능 구현 |
| 23.03.17 | DTO 정리                                                     |
| 23.03.19 | MapViewController 생성<br />MapView 구현                     |
| 23.03.20 | 위치권한 허용할 경우, MapView에 현재위치 표시되는 기능 구현<br />Button을 통해 내 위치로 이동하는 기능 구현<br />SearchBar에서 지하철역 검색 후 선택 시 MapView에 위치 표시되는 기능 구현<br />요일&시간 설정을 위한 Label&Button 구현 |
| 23.03.21 | BusViewController&ViewModel 구현<br />MapView-LongGesture 기능 구현<br />DataSelect & OptionsSelectView UI 구성 |
| 23.03.24 | AddressViewController&ViewModel 구현<br />DataSelect & OptionsSelectView 기능 구현 |
| 23.03.29 | CoreData - CRUD 기능 구현                                    |
| 23.04.03 | DataSelect & OptionsSelectView 삭제<br />AddViewController에서 Options Select 기능 수행하도록 UI 변경 |
| 23.04.04 | AddViewController 레이아웃 조정<br />AlertPresentable 구현 및 Alert 적용<br />Local Push 기능 구현<br />MapView-LongGesture 기능 삭제<br />AddViewModel 생성 후 데이터 처리 적용<br />SettingViewController 생성 및 UI 구성 |
| 23.04.05 | MARK 적용<br />코드 컨벤션 정리<br />사용하지 않는 기능 정리 |

<br>

## 💾 파일구조

### tree

```bash
<PublicTransportAlram>
├── JSONParsingTests
├── PublicTransportAlram
│   ├── Info.plist
│   ├── Resource
│   │   ├── AlarmData+CoreDataClass.swift
│   │   ├── AlarmData+CoreDataProperties.swift
│   │   ├── Assets.xcassets
│   │   └── CoreData.xcdatamodeld
│   └── Source
│       ├── App
│       │   ├── AppDelegate.swift 
│       │   ├── SceneDelegate.swift
│       │   └── Entity.xcdatamodeld
│       ├── Error
│       │   ├── CoreDataError.swift
│       │   ├── JSONError.swift
│       │   ├── NetworkError.swift
│       │   └── RequestError.swift
│       ├── Model
│       │   ├── DTO
│       │   │   ├── AlarmInformation.swift
│       │   │   ├── PublicTransitPoiDTO.swift
│       │   │   └── StationInfo.swift
│       │   ├── Extension
│       │   │   └── JSONDecoder +.swift
│       │   ├── Network
│       │   │   ├── HTTPMethod.swift
│       │   │   ├── NetworkManager.swift
│       │   │   ├── PublicTransportAPI
│       │   │   │   ├── PublicTransitPoi.swift
│       │   │   │   ├── PublicTransportService.swift
│       │   │   │   └── ServiceEnum.swift
│       │   │   └── Request.swift
│       │   └── Protocol
│       │       ├── AlertPresentable.swift
│       │       ├── CoreDataProcessable.swift
│       │       ├── Identifiable.swift
│       │       ├── LocalAlarmPushable.swift
│       │       └── LocationDataSendable.swift
│       └── Presentation
│           └── TabBar
│               ├── CustomTabBarController.swift
│               ├── List
│               │   ├── ListTableViewCell.swift
│               │   ├── ListViewController.swift
│               │   └── ListViewModel.swift
│               ├── Add
│               │   ├── AddViewController.swift
│               │   ├── AddViewModel.swift
│               │   └── SearchList
│               │       ├── Address
│               │       │   ├── AddressSearchListViewController.swift
│               │       │   └── AddressSearchListViewModel.swift
│               │       ├── Bus
│               │       │   ├── BusSearchListViewController.swift
│               │       │   └── BusSearchListViewModel.swift
│               │       ├── Subway
│               │       │   ├── SubwaySearchListViewController.swift
│               │       │   └── SubwaySearchListViewModel.swift
│               │       └── SearchListTableViewCell.swift
│               └── Setting
│                   └── SettingViewController.swift
└── PublicTransportAlram.xcodeproj
```

<br>

## 💻 실행 화면

| ![지하철](https://user-images.githubusercontent.com/102534252/231114622-49dbbcae-1e50-45fb-a201-b1177dedb1af.gif) | ![정류장](https://user-images.githubusercontent.com/102534252/231114700-8bb18581-1aa3-426d-bc60-f8990072f2d0.gif) | ![주소](https://user-images.githubusercontent.com/102534252/231114756-ea31fc7e-b92f-4d6d-833c-ccd3ec732d43.gif) |
| :----------------------------------------------: | :----------------------------------------------: | :------------------------------------------: |
|                알람 추가 - 지하철                |                 알람 추가 - 버스                 |               알람 추가 - 주소               |

| ![즐겨찾기](https://user-images.githubusercontent.com/102534252/231114858-ccc76e6b-e350-41ba-b6c9-f7fbd71c4c82.gif) | ![정보](https://user-images.githubusercontent.com/102534252/231114888-33467c89-0967-41a2-b58d-c3f23dec9c42.gif) | ![푸쉬알림](https://user-images.githubusercontent.com/102534252/231114935-c6d76ed9-da07-42bc-8797-e3019875fc6b.gif) |
| :--------------------------------------------------: | :------------------------------------------: | :--------------------------------------------------: |
|                    즐겨찾기 목록                     |                     정보                     |                 푸쉬 알림 (5회 알림)                 |

<br>

## 🎯 트러블 슈팅 및 고민

- **앱 기획**

  첫 기획은 출발지부터 목적지까지의 예상 소요시간을 구한 다음 
  예상 소요시간을 타이머에 설정하여 타이머가 완료되는 시점에 알람을 울리는 동작으로 기획하였지만,
  아래와 같은 과정을 거쳐 최종적으로는 목적지에 근접했을 때 반복적인 알림이 가도록 기획을 변경함

  - 목적지 설정

    1. 지도 API (네이버, 카카오)
       - 출발지에서 목적지까지 예상 소요시간 정보를 앱 안에 가져올 수 없었기에, 
         사용자에게 예상 소요시간은 알려줄 수 있어도 알림을 설정할 방법이 없어 사용하지 않음

    2. 서울 열린데이터광장
       - 처음에는 출발지에서 목적지까지 예상 소요시간을 알려주는 API인 줄 알았지만,
         호선별 실시간 열차 정보만 제공하고 있다는 것을 알게 되어 개발단계에서 환승에 대한 데이터 가공을 거치치 않으면 예상 소요시간 정보를 알아낼 수 없다고 판단하였고,
         데이터 가공을 거치기에는 너무 방대한 작업이 될 것이라고 생각하여 사용 보류

    3. Odsay
       - 위에서 언급한 교통 데이터를 가공하여 예상 소요시간 등등 데이터를 제공해주는 API 이기에, 초기 기획과 동일하여 사용하고자 하였지만 아래와 같은 이유로 사용하지 않음
         - 최소환승/최소시간 설정처럼 사용자에게 출발지/목적지외로 추가적인 설정을 필요로 하여 사용자에게 제공받는 정보에 비해 제공되는 서비스가 적다고 생각되었고,
           이런 점이 앱 접근성을 떨어뜨릴 수 있다고 좋지 않은 접근이라고 생각되었음
         - 결정적으로 예상 소요시간과 실제 사용자의 소요시간이 일치하지 않는 상황이 빈번하게 일어날 수 있다고 판단되었고, 정확하지 않은 알림이 제공되는 서비스는 차라리 없는게 더 나은 서비스라고 최종 결정한 후 기획을 변경함

    - 결과적으로, 출발지점과 도착지점을 알아내 소요시간을 구하려다보니 알아야하는 데이터가 많았음

      **<u>그렇다면, 필요한 최소한의 정보가 무엇일까?</u>**
      고민해본 결과, 목적지 정보만으로도 기능 구현이 가능할 것이라고 판단되어 기획을 변경하였고,
      최종적으로, 사용자의 위치타입/목적지/반경/알림횟수만을 입력받아 서비스를 제공하는 것으로 기획을 변경하게 되었음

  - 알람 방법

    - 일반 앱이 백그라운드로 빠지거나 종료될 경우 타이머가 유지되지않아 사용자에게 알람을 줄 수 없었음

      (앱이 백그라운드로 빠지게 되면 OS에서 메모리 관리를 위해 약 5~10분내로 앱을 종료시킴)

      - 타이머 앱이 어떻게 구현됬는지 찾아보았으나, 알아낼 수 없었음...

    로컬알림 기능은 앱이 종료되어도, 날짜, 시간, 장소 등의 조건으로 푸쉬 알림을 보낼 수 있었기에,
    로컬알림을 여러번 보냄으로써 유사 알람 기능을 구현 가능한지 테스트해본 결과,
    단시간에 반복적인 로컬알림은 하나의 알림으로 처리되어 사용자에게 알림반복 횟수를 1~5회 중에 선택하는 방식으로 기획을 변경하게 되었음

- ##### **MVVM 적용**

  - 이전에는 MVC 구조를 여러 번 구현했었는데, 이번에는 MVVM으로 첫 구현을 해보게 되었다.
  - MVC 구조를 구현할 때, 느낀 점은 구조의 중점만 기억해두면 어느정도 알맞는 구조가 된다는 점이였고,
    이를 바탕으로 MVVM도 아래와 같은 중점을 기준으로 구조를 구현함
    - MVC - View의 재사용을 중점으로 두는 구조
    - MVVM - 데이터는 ViewModel에서 처리해야되는 구조

- **RxSwift 적용**

  - MVVM을 처음 적용하다보니, RxSwift도 처음 사용하게 되었다.
    RxSwift는 비동기프로그래밍을 위한 도구이게 기본 개념과 사용방법을 학습 후 코드에 적용해봄
  - RxSwift 사용 중 아래와 같은 고민이 들었다.
    - 모든 부분에 RxSwift를 적용하는게 맞는가?
      - RxSwift는 비동기 프로그래밍을 기반으로 하기에, 
        비동기가 필요하지 않은 부분은 RxSwift를 사용하지 않아도 되는 것인지, 
        모든 부분을 비동기로 처리하면 Main Thread에 부담이 덜어지기에 
        모든 부분을 RxSwift를 사용해야하는 것인지 고민이 되었음
      - 결론은, 비동기가 필요한 부분만 RxSwift를 적용하였음
        - 아직 RxSwift 활용이 떨어지다보니, 검색기능 사용시 테이블뷰셀에 데이터를 뿌려줘야할 경우만 적용한 후 추후 보완할 계획!

- **네트워크 설계**

  - `오픈마켓` 프로젝트에서 네트워크 설계를 처음 했었는데, 그 당시 리뷰어가 잘 설계된 코드를 많이 보라는 조언을 해주었다.
  - 잘 설계된 코드를 많이 보지는 못했지만, 하나를 잘 살펴보니 아래와 같은 특징들을 가지고 있어 동일한 특징을 이해해서 유사하게 코드를 구현하였다.
    - 잘 설계된 네트워크란?
      - URLSession-DataTask는 서버에서 데이터를 받아 JSONDecode 후 데이터 반환 기능만 담당
      - Request 정보를 담기 위한 추상화 (Protocol + Extension 활용)
      - API를 통해 가져온 데이터를 통해 어떠한 동작을 수행할 객체
      - 네트워크 작업이 필요한 View에서 객체를 통해 필요한 동작을 수행

- **검색 기능 구현**

  - 지하철역 검색 - Odsay에서 제공하는 API를 사용하여 지하철역 검색하는 방식

    - API에 위도, 경도 값을 넣어 해당 위치 반경 500m내에 존재하는 지하철역을 검색
      - 호선이 많은 몇가지 역들을 테스트해본 결과 반경 500m안에 모든 호선이 뜨는 것 확인
    - 지하철역의 위도, 경도 값을 얻기 위해 모든 지하철역의 위도, 경도값이 저장된 JSON파일 사용

    사용자가 지하철역을 입력하면 JSON파일에서 해당 지하철의 존재유무를 확인하여 값이 있으면 위도, 경도값을 API에 넣어 주변 지하철역까지 검색해주는 방식

  - 버스정류장 검색 - Odsay에서 제공하는 API와 MKLocalSearch를 사용하여 정류장 검색하는 방식

    - 지하철과 동일하게 API에 위도, 경도 값을 넣어 해당 위치 반경 500m내에 존재하는 정류장을 검색
    - MKLocalSearch의 resultTypes를 pointOfInterest로 설정하여 사용자가 입력한 정보을 기반으로   가장 첫번째에 뜨는 위치를 기준으로 위도, 경도 값 확인

    사용자가 정확한 버스정류장역을 입력하기 어려울 것을 대비하여, 정류장 근처 유명한 지역이름 검색만으로도 쉽게 검색 가능하도록 MKLocalSearch를 추가 활용하여 정류장을 검색해주는 방식

    > MKLocalSearch를 통해 찾아낸 가장 첫번째 장소를 사용하다보니, 어느 지역에서는 분명한 오류가 있을 것으로 예상되지만, 추후 보완 예정!

  - 주소 검색 - MKLocalSearch를 사용하여 주소 위치를 검색하는 방식

    - 주소 검색은 MKLocalSearch에서 기본적으로 사용할 수 있는 resultTypes - Address 기능을 활용

    사용자가 입력한 정보를 MKLocalSearch에서 주소정보만을 뽑아내어 검색해주는 방식

- **SerchList관련된 View 재사용 또는 통합**

  - 지하철, 버스, 주소 검색창의 UI가 모두 동일하지만, 데이터관리측면에서 MVVM패턴을 구현하다보니 동일한 UI를 가진 3개의 ViewController가 존재하는 것이 좋은 방법인가에 대한 물음표가 달렸음
    - 결론적으로, 3개의 ViewController가 존재해도 된다고 아래의 2가지 근거를 기준으로 판단하였음
      1. MVVM 구조를 구현해야하니 UI가 중점이 아님
      2. 같은 UI이지만, 각각의 View에서 관리하는 데이터가 다르다보니 구분이 필요하다고 판단

- **내부 데이터 관리**

  - 내부 데이터 관리에 활용할 수 있는 기술스택 중 CoreData를 선택한 이유!
    1. UserDefaults : 사용자가 앱에서 입력한 정보를 담기엔 부적합
    1. SQLite : 수많은 프로세스와 스레드의 접근으로부터 안전하지만 굳이 많이 안전할 필요다고 판단
    1. Realm : 빠른 속도는 필요하지 않았음
       - 결론은, 사용해본 경험이 있고 간단한 앱이기에 CoreData 사용으로도 충분하다고 판단

- **위치 권한을 `항상`으로 초기 설정이 불가능한 점**

  - 앱의 기능상 앱 종료 후에도 사용자가 목적지에 근접했는지를 알기 위해서는 앱의 위치권한이 `항상`으로 설정되어야 정상적인 동작이 수행될 수 있음
    - 앱 내에서 사용자가 앱의 위치권한을 설정할 때, `항상`이라는 선택지가 없음
      - 설정 - 앱 - 위치 - 위치 접근 허용 - `항상`으로 변경하는 작업을 사용자가 해줘야 함
    - `CLLocationManagerDelegate` - `locationManagerDidChangeAuthorization` 메서드를 통해 앱의 위치권한 설정이 어떻게 되었는지에 따라 동작을 수행시킬 수 있음
    - 앱을 실행할 때마다, 위치권한을 확인하여 `항상`이 아니라면 위치권한 변경이 필요하다는 Alert를 띄움으로써 사용자에게 앱의 기능을 사용하기 위해서는 설정 변경이 필요하다는 정보을 알려줌

<br>

## 🙅‍♂️ 출시심사 리젝
##### **1. Guideline 1.5 - Safety - Developer Information**

- 앱 소개 링크가 보이지 않는 이슈
  - 앱 소개 링크를 노션으로 등록해두었는데 노션 페이지 편집하다 쉐어 옵션이 변경됨
  - 쉐어 옵션을 공개로 수정한 후 확인 결과 링크 확인 가능

##### **2. Guideline 2.1 - Performance - App Completeness**

- 지하철역 검색시 "강남역"을 입력하면 확인 불가한 현상
- 현재는 `강남역`을 검색하기 위해서는 `강남`을 입력해야 검색이 가능! ("역" 필요없음)
  - 사용자가 "강남역"을 키보드로 칠 경우만 생각함
    - 위 경우, ""강남역""을 치기위해 ""강남""을 치게 되면서 자연스럽게 지하철 정보 확인 가능
  - 사용자가 "강남역"이란 단어를 복사해서 가져오는 경우를 생각하지 못함
    - 위 경우를 해결하기 위해 검색단어에 "역"이 있을 경우 "역"을 제거하는 기능 구현

##### **3. Guideline 5.1.1 - Legal - Privacy - Data Collection and Storage**

- 위치정보를 사용하기 때문에 앱에 액세스해야 하는 이유가 필요
  - 현재 아래 그림과 같이 "지도 권한 필요"라고만 적혀져 있는 것이 문제가 되듯하여 문구 수정!
  
  <br>

![스크린샷 2023-04-12 오후 10 14 20](https://user-images.githubusercontent.com/102534252/231468777-f6c46054-a4a4-4cd2-85ae-4918510f7f08.png)

- Info.plist파일에서 목적문자열을 수정하면 됨

<br>

![스크린샷 2023-04-13 오전 10 47 24](https://user-images.githubusercontent.com/102534252/231625348-8ae5039b-6ba4-4e86-85c7-871ddc9f7e1c.png)

<br>

## 😇 회상

이번 프로젝트는 기획으로 시작해서 기획으로 끝났다.

사회생활을 개발업무만 하다보니 기획의 중요성을 잊은 채, 개발만 했었는데 이번 프로젝트를 통해 기획이 잘못되면 정말 돌고 돌고 돌고 돌고 돌고 돌 수 있다는 위험성을 알게 되었다. (기획자 짱...!)

프로젝트를 수행하기전 기획을 구상할 때, 머리로 이렇게 이렇게하면 되겠지라고 간단하게 생각했었는데 이번 프로젝트에서 겪었던 점은 혼자서 실제 구현이 가능한 작업인지와 아이폰에서 제공되는 기능인지에 대한 철저한 사전조사가 필요했고 그 외 부가적으로 자잘한 부분들에 대해서도 정확하게 파악되지 않으면 언제 어떻게 시간낭비가 될지 모른다는 점에서 기획이 정말 중요하다는 것을 깨닫게 되었다.

이번 프로젝트에서 제작된 앱은 굉장히 작고 간단한 앱이지만, 덩치가 큰 앱에서는 더더욱 기획이 중요할 것이라는 생각이 듬과 동시에 기획자들이 괜히 있는게 아니였구나 라고 생각할 수 있었다.



다음으로 중요했던 것은 디자인! ⭐️

정말 디자인은 앱의 얼굴이였다...
대부분의 사람이 잘생기거나 이쁜 사람에게 끌리듯이 앱도 이뻐야 끌린다는 것을 알게 되었다.
그리고, 앱을 이쁘게 꾸미는게 얼마나 어려운지... 뼈저리게 느꼈다...

개발자들이 디자인적으로 흔히 하는 실수들이 너무 상세하게 보여주려고 하다보니 디자인을 무너뜨리는 경향이 많다는 글을 본 것 같은데 처음 UI 구현을 할 때, 나 또한 디자인이 무너뜨리면서 UI 작업을 하고 있었다...🥲

그래서 심플 이즈 베스트를 마음에 새기고 UI를 갈아업으니 나름 봐줄만한 UI가 되긴 했지만,
기획처럼 거대한 앱에서 디자인이 얼마나 중요한지 확실하게 느낄 수 있었다... (디자이너 짱...!)

위 두가지 깨달음을 통해 기획자와 디자이너들의 역량에 따라 사용자의 마음을 잡냐 못잡냐가 판가름 나는 것 같다



마지막으로는 초급 개발자로써 가져야하는 자세를 알게 된 것 같다

MVVM + RxSwift로 처음 구현하다보니 철저한 개념조사를 위해 많은 시간을 쏟아부었지만, 
정작 코드를 쓰려고보니 이게 맞나라는 생각에 사로잡혀 아무것도 쓸 수 없던 내 모습을 보았다.

물론 개념의 중요성은 너무너무 잘알고 있지만, 개발자는 오류 개선처럼 잘못된 것을 파악해서 고쳐나가야하는 자세가 필요하기에 잘못된 코드를 적더라도 두려워하지말고 일단 코드를 적고 나중에 틀린 부분을 찾아가며 고쳐나가는 자세도 중요하다는 것을 느끼게 되었다.

추가로, 자기 객관화도 필요하다... 나는 코딩천재가 아니고 코딩경력도 길지 않은 초급개발자라는 것을 명심!



처음 제작한 앱이라 간단한 기능만을 담고 있지만, 나름 뿌듯!
