import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - NowPlayingSideEffect

struct NowPlayingSideEffect {
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

extension NowPlayingSideEffect {
  var getItem: (MovieEntity.Movie.NowPlaying.Request) -> Effect<NowPlayingReducer.Action> {
    { item in
      .publisher {
        useCase.movieUseCase.nowPlaying(item)
          .receive(on: main)
          .mapToResult()
          .map(NowPlayingReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MovieEntity.Movie.NowPlaying.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.Movie.NowPlaying.Item {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(
      pathList: .init(movieID: id),
      queryItemPath: .init())
  }
}
