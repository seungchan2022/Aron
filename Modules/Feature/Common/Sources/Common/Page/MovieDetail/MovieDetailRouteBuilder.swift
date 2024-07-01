import Architecture
import Domain
import LinkNavigator

struct MovieDetailRouteBuilder<RootNavigator: RootNavigatorType> {
  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Common.Path.movieDetail.rawValue

    return .init(matchPath: matchPath) { navigator, items, diContainer -> RouteViewController? in
      guard let env: CommonEnvironmentUsable = diContainer.resolve() else { return .none }
      guard let item: MovieEntity.MovieDetail.MovieCard.Request = items.decoded() else { return .none }
      guard let reviewItem: MovieEntity.MovieDetail.Review.Request = items.decoded() else { return .none }
      guard let creditItem: MovieEntity.MovieDetail.Credit.Request = items.decoded() else { return .none }
      guard let similarMovieItem: MovieEntity.MovieDetail.SimilarMovie.Request = items.decoded() else { return .none }
      guard let recommendedMovieItem: MovieEntity.MovieDetail.RecommendedMovie.Request = items.decoded() else { return .none }

      return DebugWrappingController(matchPath: matchPath) {
        MovieDetailPage(store: .init(
          initialState: MovieDetailReducer.State(
            item: item,
            reviewItem: reviewItem,
            creditItem: creditItem,
            similarMovieItem: similarMovieItem,
            recommendedMovieItem: recommendedMovieItem),
          reducer: {
            MovieDetailReducer(sideEffect: .init(
              useCase: env,
              navigator: navigator))
          }))
      }
    }
  }
}
