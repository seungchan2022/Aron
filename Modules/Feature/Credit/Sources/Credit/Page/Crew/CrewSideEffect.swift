import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - CrewSideEffect

public struct CrewSideEffect {
  public let useCase: CreditEnvironmentUsable
  public let main: AnySchedulerOf<DispatchQueue>
  public let navigator: RootNavigatorType

  public init(
    useCase: CreditEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension CrewSideEffect {
  var crew: (MovieEntity.MovieDetail.Credit.Request) -> Effect<CrewReducer.Action> {
    { request in
      .publisher {
        useCase.movieDetailUseCase.credit(request)
          .receive(on: main)
          .mapToResult()
          .map(CrewReducer.Action.fetchCrewItem)
      }
    }
  }

  var routeToProfile: (MovieEntity.MovieDetail.Credit.CrewItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Common.Path.profile.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.MovieDetail.Credit.CrewItem {
  fileprivate func serialized() -> MovieEntity.Person.Info.Request {
    .init(personID: id)
  }
}
