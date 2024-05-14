import ComposableArchitecture
import Dashboard
import Domain
import Foundation
import Platform
import XCTest

final class MovieDetailTests: XCTestCase {
  
  override class func tearDown() {
    super.tearDown()
  }
  
}

extension MovieDetailTests {
  struct SUT {
    
    init() {
      let container = AppContainerMock.generate()
      let main = DispatchQueue.test
      
      self.container = container
      self.scheduler = main
      
      self.store = .init(
        initialState: MovieDetailReducer.State(
          item: .init(movieID: 1),
          reviewItem: .init(movieID: 1),
          creditItem: .init(movieID: 1),
          similarMovieItem: .init(movieID: 1),
          recommendedMovieItem: .init(movieID: 1)),
        reducer: {
          MovieDetailReducer(
            sideEffect: .init(
              useCase: container,
              main: main.eraseToAnyScheduler(),
              navigator: container.linkNavigatorMock))
        })
    }
    
    let container: AppContainerMock
    let scheduler: TestSchedulerOf<DispatchQueue>
    let store: TestStore<MovieDetailReducer.State, MovieDetailReducer.Action>
  }
}
