import ComposableArchitecture
import Dashboard
import Domain
import Foundation
import Platform
import XCTest

// MARK: - HomeTests

final class HomeTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }

  @MainActor
  func test_binding() async {
    let sut = SUT()

    await sut.store.send(.binding(.set(\.searchMovieItemList, [])))
  }

  @MainActor
  func test_teardown() async {
    let sut = SUT()

    await sut.store.send(.teardown)
  }

  @MainActor
  func test_binding_query_case1() async {
    var newState = HomeReducer.State()
    newState.query = "test"
    newState.searchMovieItemList = []
    newState.searchKeywordItemList = []
    newState.searchPersonItemList = []

    let sut = SUT(state: newState)

    await sut.store.send(.set(\.query, "")) { state in
      state.query = ""
    }
  }

  @MainActor
  func test_binding_query_case2() async {
    var newState = HomeReducer.State()

    newState.query = "test"

    newState.searchMovieItemList = ResponseMock().response.searchMovie.successValue.itemList
    newState.searchKeywordItemList = ResponseMock().response.searchKeyword.successValue.itemList
    newState.searchPersonItemList = ResponseMock().response.searchPerson.successValue.itemList

    let sut = SUT(state: newState)

    await sut.store.send(.set(\.query, "")) { state in
      state.query = ""
      state.searchMovieItemList = []
      state.searchKeywordItemList = []
      state.searchPersonItemList = []
    }
  }

  @MainActor
  func test_binding_query_case3() async {
    var newState = HomeReducer.State()
    newState.query = ""

    newState.searchMovieItemList = []
    newState.searchKeywordItemList = []
    newState.searchPersonItemList = []

    let sut = SUT(state: newState)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
    }
  }

  @MainActor
  func test_binding_query_case4() async {
    let movieResponseMock: MovieEntity.Search.Movie.Response = ResponseMock().response.searchMovie.successValue
    let keywordResponseMock: MovieEntity.Search.Keyword.Response = ResponseMock().response.searchKeyword.successValue
    let personResponseMock: MovieEntity.Search.Person.Response = ResponseMock().response.searchPerson.successValue

    var newState = HomeReducer.State()
    newState.query = "spierman"
    newState.searchMovieItemList = movieResponseMock.itemList
    newState.searchKeywordItemList = keywordResponseMock.itemList
    newState.searchPersonItemList = personResponseMock.itemList

    let sut = SUT(state: newState)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
      state.searchMovieItemList = []
      state.searchKeywordItemList = []
      state.searchPersonItemList = []
    }
  }

  @MainActor
  func test_searchMovie_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Search.Movie.Composite = .init(
      request: .init(query: "test"),
      response: ResponseMock().response.searchMovie.successValue)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
    }

    await sut.store.send(.searchMovie("test")) { state in
      state.fetchSearchMovieItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSearchMovieItem) { state in
      state.fetchSearchMovieItem.isLoading = false
      state.fetchSearchMovieItem.value = responseMock
      state.searchMovieItemList = responseMock.response.itemList
    }
  }

  @MainActor
  func test_searchMovie_failure_case() async {
    let sut = SUT()

    sut.container.searchUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
    }

    await sut.store.send(.searchMovie("test")) { state in
      state.fetchSearchMovieItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSearchMovieItem) { state in
      state.fetchSearchMovieItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_searchKeyword_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Search.Keyword.Composite = .init(
      request: .init(query: "test"),
      response: ResponseMock().response.searchKeyword.successValue)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
    }

    await sut.store.send(.searchKeyword("test")) { state in
      state.fetchSearchKeywordItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSearchKeywordItem) { state in
      state.fetchSearchKeywordItem.isLoading = false
      state.fetchSearchKeywordItem.value = responseMock
      state.searchKeywordItemList = responseMock.response.itemList
    }
  }

  @MainActor
  func test_searchKeyword_failure_case() async {
    let sut = SUT()

    sut.container.searchUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
    }

    await sut.store.send(.searchKeyword("test")) { state in
      state.fetchSearchKeywordItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSearchKeywordItem) { state in
      state.fetchSearchKeywordItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_searchPerson_success_case() async {
    let sut = SUT()

    let responseMock: MovieEntity.Search.Person.Composite = .init(
      request: .init(query: "test"),
      response: ResponseMock().response.searchPerson.successValue)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
    }

    await sut.store.send(.searchPerson("test")) { state in
      state.fetchSearchPersonItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSearchPersonItem) { state in
      state.fetchSearchPersonItem.isLoading = false
      state.fetchSearchPersonItem.value = responseMock
      state.searchPersonItemList = responseMock.response.itemList
    }
  }

  @MainActor
  func test_searchPerson_failure_case() async {
    let sut = SUT()

    sut.container.searchUseCaseStub.type = .failure(.invalidTypeCasting)

    await sut.store.send(.set(\.query, "test")) { state in
      state.query = "test"
    }

    await sut.store.send(.searchPerson("test")) { state in
      state.fetchSearchPersonItem.isLoading = true
    }

    await sut.scheduler.advance()

    await sut.store.receive(\.fetchSearchPersonItem) { state in
      state.fetchSearchPersonItem.isLoading = false
    }

    await sut.store.receive(\.throwError)
  }

  @MainActor
  func test_routeToMovieList_case() async {
    let sut = SUT()

    await sut.store.send(.routeToMovieList)
  }

  @MainActor
  func test_routeToSearchMovieDetail_case() async {
    let sut = SUT()

    let pick: MovieEntity.Search.Movie.Item = ResponseMock().response.searchMovie.successValue.itemList.first!

    await sut.store.send(.routeToSearchMovieDetail(pick))
  }

  @MainActor
  func test_routeToKeyword_case() async {
    let sut = SUT()

    let pick: MovieEntity.Search.Keyword.Item = ResponseMock().response.searchKeyword.successValue.itemList.first!

    await sut.store.send(.routeToSearchKeyword(pick))
  }

  @MainActor
  func test_routeToSearchPerson_case() async {
    let sut = SUT()

    let pick: MovieEntity.Search.Person.Item = ResponseMock().response.searchPerson.successValue.itemList.first!

    await sut.store.send(.routeToSearchPerson(pick))
  }
}

extension HomeTests {
  struct SUT {

    // MARK: Lifecycle

    init(state: HomeReducer.State = .init()) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test

      self.container = container
      scheduler = main

      store = .init(
        initialState: state,
        reducer: {
          HomeReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigator))
        })
    }

    // MARK: Internal

    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<HomeReducer.State, HomeReducer.Action>
  }

  struct ResponseMock {
    let response: SearchUseCaseStub.Response = .init()
    init() { }
  }
}
