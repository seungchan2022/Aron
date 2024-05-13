import ComposableArchitecture
import Domain
import Foundation
import Platform
import Dashboard
import XCTest

final class UpcomingTests: XCTestCase {
  
  override class func tearDown() {
    super.tearDown()
  }
  
  @MainActor
  func test_binding() async {
    let sut = SUT()
    
    await sut.store.send(.binding(.set(\.itemList, [])))
  }
  
  @MainActor
  func test_teardown() async {
    let sut = SUT()
    
    await sut.store.send(.teardown)
  }
  
  @MainActor
  func test_getItem_success_case() async {
    let sut = SUT()
    
    let responseMock: MovieEntity.Movie.Upcoming.Response = ResponseMock().response.upcoming.successValue
    
    await sut.store.send(.getItem) { state in
      state.fetchItem.isLoading = true
    }
    
    await sut.scheduler.advance()
    
    await sut.store.receive(\.fetchItem) { state in
      state.fetchItem.isLoading = false
      state.fetchItem.value = responseMock
      state.itemList = responseMock.itemList
    }
  }
  
  @MainActor
  func test_getItem_failure_case() async {
    let sut = SUT()
    
    sut.container.movieUseCaseStub.type = .failure(.invalidTypeCasting)
    
    await sut.store.send(.getItem) { state in
      state.fetchItem.isLoading = true
    }
    
    await sut.scheduler.advance()
    
    await sut.store.receive(\.fetchItem) { state in
      state.fetchItem.isLoading = false
    }
    
    await sut.store.receive(\.throwError)
  }
  
  @MainActor
  func test_routeToDetail_case() async {
     let sut = SUT()
    
    let pick = ResponseMock().response.upcoming.successValue.itemList.first!
    
    await sut.store.send(.routeToDetail(pick))
    
    XCTAssertEqual(sut.container.linkNavigatorMock.event.next, 1)
  }
}

extension UpcomingTests {
  struct SUT {
    
    init(state: UpcomingReducer.State = .init()) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test
      
      self.container = container
      self.scheduler = main
      
      self.store = .init(
        initialState: state,
        reducer: {
          UpcomingReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigator))
        })
      
    }
    
    
    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<UpcomingReducer.State, UpcomingReducer.Action>
  }
  
  struct ResponseMock {
    let response: MovieUseCaseStub.Response = .init()
    init() { }
  }
}
