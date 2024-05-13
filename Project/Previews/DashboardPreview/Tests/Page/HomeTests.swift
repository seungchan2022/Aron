import ComposableArchitecture
import Domain
import Dashboard
import Foundation
import Platform
import XCTest

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
}

extension HomeTests {
  struct SUT {
    
    init(state: HomeReducer.State = .init()) {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test
      
      self.container = container
      self.scheduler = main
      
      self.store = .init(
        initialState: state,
        reducer: {
          HomeReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigator))
        })
    }
    
    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<HomeReducer.State, HomeReducer.Action>
  }
  
  struct ResponseMock {
    let response: SearchUseCaseStub.Response = .init()
    init() { }
  }
}
