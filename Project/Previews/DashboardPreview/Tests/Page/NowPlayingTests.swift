import Dashboard
import ComposableArchitecture
import Domain
import XCTest
import Foundation
import Platform

final class NowPlayingTests: XCTestCase {
  override class func tearDown() {
    super.tearDown()
  }
  
//  @MainActor
//  func test_teardown() async {
//    let sut = SUT()
//    
//    await sut.store.send(.teardown)
//  }
  
  @MainActor
  func test_getItem_success_case() async {
    let sut = SUT()
    
    let responseMock: MovieEntity.Movie.NowPlaying.Response = ResponseMock().response.nowPlaying.successValue
    
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
  
}

extension NowPlayingTests {
  struct SUT {

    init(state: NowPlayingReducer.State = .init()) {
      let container = AppContainerMock.build()
      let main = DispatchQueue.test
      
      self.container = container
      self.scheduler = main
      
      self.store = .init(
        initialState: state,
        reducer: {
          NowPlayingReducer(
            sideEffect: .init(
              useCase: container.dependency,
              main: main.eraseToAnyScheduler(),
              navigator: container.navigator))
        })
    }
//    
//    init(state: NowPlayingReducer.State = .init()) {
//      let container = AppContainerMock.generate()
//      let main = DispatchQueue.test
//      
//      self.container = container
//      self.scheduler = main
//      
//      self.store = .init(
//        initialState: state,
//        reducer: {
//          NowPlayingReducer(
//            sideEffect: .init(
//              useCase: container,
//              main: main.eraseToAnyScheduler(),
//              navigator: container.linkNavigatorMock))
//        })
//    }
    
    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<NowPlayingReducer.State, NowPlayingReducer.Action>
  }
  
  struct ResponseMock {
    let response: MovieUseCaseStub.Response = .init()
    init() { }
  }
}
