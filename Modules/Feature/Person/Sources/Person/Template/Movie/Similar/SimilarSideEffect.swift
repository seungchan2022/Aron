import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SimilarSideEffect

public struct SimilarSideEffect {
  public let useCase: PersonEnvironmentUsable
  public let main: AnySchedulerOf<DispatchQueue>
  public let navigator: RootNavigatorType

  public init(
    useCase: PersonEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension SimilarSideEffect {
  var similar: (MovieEntity.MovieDetail.SimilarMovie.Request) -> Effect<SimilarReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.similarMovie(request)
          .receive(on: main)
          .mapToResult()
          .map(SimilarReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MovieEntity.MovieDetail.SimilarMovie.Response.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.SimilarMovie.Response.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.SimilarMovie.Request {
    .init(movieID: id)
  }
}
