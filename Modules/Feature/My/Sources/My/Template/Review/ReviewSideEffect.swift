import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - ReviewSideEffect

public struct ReviewSideEffect {
  public let useCase: MyEnvironmentUsable
  public let main: AnySchedulerOf<DispatchQueue>
  public let navigator: RootNavigatorType

  public init(
    useCase: MyEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension ReviewSideEffect {
  var review: (MovieEntity.MovieDetail.MovieCard.Response) -> Effect<ReviewReducer.Action> {
    { item in
      .publisher {
        useCase.movieDetailUseCase.review(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ReviewReducer.Action.fetchReviewItem)
      }
    }
  }
}

extension MovieEntity.MovieDetail.MovieCard.Response {
  fileprivate func serialized() -> MovieEntity.MovieDetail.Review.Request {
    .init(movieID: id)
  }
}
