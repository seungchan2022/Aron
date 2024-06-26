import Architecture
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - FanClubSideEffect

public struct FanClubSideEffect {
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

extension FanClubSideEffect {
  var getItem: (MovieEntity.FanClub.Request) -> Effect<FanClubReducer.Action> {
    { item in
      .publisher {
        useCase.fanClubUseCase.fanClub(item)
          .receive(on: main)
          .mapToResult()
          .map(FanClubReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MovieEntity.FanClub.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Common.Path.profile.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.FanClub.Item {
  fileprivate func serialized() -> MovieEntity.Person.Info.Request {
    .init(personID: id)
  }
}
