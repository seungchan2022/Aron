# Aron


## 📋 프로젝트 소개

해당 프로젝트는 [MovieSwiftUI](https://github.com/Dimillian/MovieSwiftUI)의 클론앱으로, API와 시뮬레이터 화면만 참고하고, 저만의 방식으로 코드를 작성하였습니다.

<br>

## 📌 API

API는 [MovieSwiftUI](https://github.com/Dimillian/MovieSwiftUI)를 실행해서 [Proxyman](https://proxyman.io/)으로 참고하였습니다.

<p align="center">
	<img alt="API" src="https://github.com/seungchan2022/Aron/assets/110214307/4a2049ba-84af-4cbf-a7b3-b392a6ee5bdb", style="width: 80%;">
</p>


<br>

`iOS 17+` `SwiftUI` `CleanArchitecutre` `TCA` `LinkNavigator`

<br>

## 📱 탭 별 기능
|Movie 탭|Movie 탭 (Search)|
|-|-|
|온보딩 형식으로 해당 키워드에 맞는 영화를 찾아 볼수 있고,<br>여러 키워드의 영화들을 한 번에 찾아 볼수 있습니다.|검색어를 입력함으로써 영화나 사람을 검색할 수 있습니다.|
|<img src="https://github.com/seungchan2022/Aron/assets/110214307/6c7a1bc4-853f-41ef-b0ac-5de2036bddde" style="width: 60%;">|<img src="https://github.com/seungchan2022/Aron/assets/110214307/66d9f7e6-9881-46b8-bdaf-086bd25f78f7" style="width: 60%;">|

|Discover 탭|Fan Club 탭|My List 탭|
|-|-|-|
|영화 포스터를 보면서 간편하게 원하는 영화를 찾을 수 있습니다.|원하는 사람의 프로필을 확인 할 수 있습니다.|본인이 원하는 영화를 원하는 리스트에 추가 할 수 있습니다.|
|<img src="https://github.com/seungchan2022/Aron/assets/110214307/6a6fddb3-e979-4153-bdcc-a25c6d5af270" style="width: 60%;">|<img src="https://github.com/seungchan2022/Aron/assets/110214307/3e0365e9-b440-4d62-a5f1-ddd098c5add8" style="width: 60%;">|<img src="https://github.com/seungchan2022/Aron/assets/110214307/a9092fe6-67dc-4601-a52c-7f30260399bd" style="width: 60%;">|

<br>

<details>
<summary><strong style="font-size: 1.2em;">&nbsp;&nbsp;다크 모드</strong></summary>

|Movie 탭|Movie 탭 (Search)|
|-|-|
|온보딩 형식으로 해당 키워드에 맞는 영화를 찾아 볼수 있고, 여러 키워드의 영화들을 한 번에 찾아 볼수 있습니다.|검색어를 입력함으로써 영화나 사람을 검색할 수 있습니다.|
|<img src="https://github.com/seungchan2022/Aron/assets/110214307/262480d3-44fb-4a74-a54d-522a0a178851" style="width: 60%;">|<img src="https://github.com/seungchan2022/Aron/assets/110214307/5c066a41-121c-4aa3-94b0-e6009f976dbc" style="width: 60%;">|

|Discover 탭|Fan Club 탭|My List 탭|
|-|-|-|
|영화 포스터를 보면서 간편하게 원하는 영화를 찾을 수 있습니다.|원하는 사람의 프로필을 확인 할 수 있습니다.|본인이 원하는 영화를 원하는 리스트에 추가 할 수 있습니다.|
|<img src="https://github.com/seungchan2022/Aron/assets/110214307/bc9420d3-f66d-4441-b0dc-494933a9a155" style="width: 60%;">|<img src="https://github.com/seungchan2022/Aron/assets/110214307/d31e2272-0477-464a-b8f3-cb9ac2e4dfdd" style="width: 60%;">|<img src="https://github.com/seungchan2022/Aron/assets/110214307/8a4d94a4-2a1e-47f3-b01b-1347aea785b2" style="width: 60%;">|
  
</details>

<br>


## 👀 예외 처리
* 예외 처리를 통해 사용자에게 현재 상태를 명확하게 전달하고, 예상치 못한 상황에서도 적절한 피드백을 제공함으로써 사용자 경험을 개선합니다.

* 예외 상황을 처리하는 이러한 접근 방식은 사용자가 애플리케이션을 더 쉽게 이해하고 사용할 수 있도록 도와줍니다.

<br>

### 1. 검색 결과
---

* 한개의 검색어를 가지고 3개의 검색 결과를 가져오는데, 각 결과에 따라서 예외 처리를 해줍니다.
* 예를 들어 아래 이미지들을 보면 "Dgf"라는 단어를 검색 했는데 Keyword와 People에 대해서는 검색 결과가 없으므로 **"No Result"** 라는 메시지를 사용자에게 알려줍니다.

<br>

|<img width="60%" src="https://github.com/seungchan2022/Aron/assets/110214307/f38cbe2a-86ae-4594-a60d-1f206278cd7d">|<img width="60%" src="https://github.com/seungchan2022/Aron/assets/110214307/31fbd56e-4c59-44f6-9167-ecc34378fc94">|
|:---:|:---:|
<br>

### 2. 데이터 로드
---

* 로딩 인디케이터와 SwiftUI의 `redacted`를 사용하여 컨텐츠가 로딩 되는 동안 어색하지 않고, <br>유저에게 데이터를 불러오고 있다는 것을 직관적으로 전달 할 수 있습니다.

<br>

<p align="center">
  <img width="30%" alt="데이터 로드" src="https://github.com/seungchan2022/Aron/assets/110214307/63fe024a-a906-41cf-993e-8a02f6108cf6">
</p>

<br>

## ✨ 테마 변경 기능

* 애플리케이션 내에서 테마를 선택하여 사용할 수 있습니다.
* 사용자는 개인 취향에 맞게 애플리케이션의 테마를 선택하여 사용 할 수 있습니다.
* 테마 변경은 사용자의 상황에 따라 시각적 편의성을 제공할 수 있습니다.
* [참고](https://www.youtube.com/watch?v=aHtDymtNdSs)

<p align="center">
  <img width="30%" src="https://github.com/seungchan2022/Aron/assets/110214307/1ab54727-b4fe-4ae4-aa41-12f381205f39">
</p>

<br>

## 📚 모듈화
 
* 한 프로젝트에서 각 테마 별로 모듈로 나누어 모듈화를 진행했습니다.
* 모듈화를 함으로써 각 모듈이 독립성을 가지고, 코드를 구조화 되며, 재사용 가능하고 유지 보수를 효율적으로 만듭니다.

<br>

|프로젝트 구조 구상|실제 프로젝트 구조|
|-|-|
|<img src="https://github.com/seungchan2022/Aron/assets/110214307/5e026f2a-77b8-4dae-ae50-4c6488249316" alt="Mind">|<img src="https://github.com/seungchan2022/Aron/assets/110214307/9dc167b4-9958-489d-8b7e-198991f44eda" alt="Module">

<br>

## 🛠️ 테스트 코드
* 테스트 코드를 작성함으로써 작성한 코드가 제대로 작동하는지 확인 할 수 있으며, 코드에 대한 이해를 높여줍니다.

<br>

|Fake에 대한 테스트 코드|Stub에 대한 테스트 코드|
|:---:|:---:|
|<img alt="테스트코드_Fake" src="https://github.com/seungchan2022/Aron/assets/110214307/fc71aac0-836d-4b2a-b9d4-dfa82948db54">|<img alt="테스트코드_Stub" src="https://github.com/seungchan2022/Aron/assets/110214307/8d8ef0be-0f21-453e-8f9b-9ac6fde0bfd4">|

<br>

<details>
<summary>&nbsp;&nbsp;테스트 환경에서 사용되는 객체</summary>

> * **Dummy 객체**는 전달되지만 실제로는 사용되지 않습니다. 보통 매개변수 목록을 채우는 데만 사용됩니다.
> 
> * **Fake 객체**는 실제로 작동하는 구현을 가지고 있지만 일반적으로 프로덕션에 적합하지 않은 지름길을 사용합니다.
> 
> * **Stub은** 테스트 중 호출에 대해 미리 준비된 답변을 제공하며, 일반적으로 테스트를 위해 프로그래밍된 것 이외의 것에는 전혀 응답하지 않습니다.
> 
> * **Spy**는 호출 방식에 따라 일부 정보를 기록하는 스텁입니다. 한 가지 예시로는 전송된 메시지 수를 기록하는 이메일 서비스일 수 있습니다.
> 
> * **Mock**는 예상되는 호출에 대한 기대값으로 미리 프로그래밍된 객체입니다.
> 
> #### [개념 출처](https://martinfowler.com/articles/mocksArentStubs.html )

</details>
<br>

