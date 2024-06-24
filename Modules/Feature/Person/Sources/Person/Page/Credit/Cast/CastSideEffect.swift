import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - CastSideEffect

public struct CastSideEffect {
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

extension CastSideEffect {
  var cast: (MovieEntity.MovieDetail.Credit.Request) -> Effect<CastReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.credit(request)
          .receive(on: main)
          .mapToResult()
          .map(CastReducer.Action.fetchCastItem)
      }
    }
  }

  var routeToProfile: (MovieEntity.MovieDetail.Credit.CastItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Person.Path.profile.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.Credit.CastItem {
  fileprivate func serialized() -> MovieEntity.Person.Info.Request {
    .init(personID: id)
  }
}
