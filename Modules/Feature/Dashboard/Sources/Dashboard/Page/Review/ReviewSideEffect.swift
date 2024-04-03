import Architecture
import ComposableArchitecture
import Domain
import Foundation
import CombineExt

struct ReviewSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType
  
  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension ReviewSideEffect { 
  var review: (MovieEntity.MovieDetail.Review.Request) -> Effect<ReviewReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.review(request)
          .receive(on: main)
          .mapToResult()
          .map(ReviewReducer.Action.fetchReviewItem)
      }
    }
  }
}
