import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - ProfileSideEffect

public struct ProfileSideEffect {
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

extension ProfileSideEffect {
  var item: (MovieEntity.Person.Info.Request) -> Effect<ProfileReducer.Action> {
    { request in
      .publisher {
        useCase.personUseCase.info(request)
          .receive(on: main)
          .mapToResult()
          .map(ProfileReducer.Action.fetchItem)
      }
    }
  }

  var profileImage: (MovieEntity.Person.Image.Request) -> Effect<ProfileReducer.Action> {
    { request in
      .publisher {
        useCase.personUseCase.image(request)
          .receive(on: main)
          .mapToResult()
          .map(ProfileReducer.Action.fetchProfileImage)
      }
    }
  }

  var movieCredit: (MovieEntity.Person.MovieCredit.Request) -> Effect<ProfileReducer.Action> {
    { request in
      .publisher {
        useCase.personUseCase.movieCredit(request)
          .receive(on: main)
          .mapToResult()
          .map(ProfileReducer.Action.fetchMovieCreditItem)
      }
    }
  }

  var routeToCastDetail: (MovieEntity.Person.MovieCredit.CastItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }

  var routeToCrewDetail: (MovieEntity.Person.MovieCredit.CrewItem) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.movieDetail.rawValue,
          items: item.serialized()),
        isAnimated: true)
    }
  }
}

extension MovieEntity.Person.MovieCredit.CastItem {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}

extension MovieEntity.Person.MovieCredit.CrewItem {
  fileprivate func serialized() -> MovieEntity.MovieDetail.MovieCard.Request {
    .init(movieID: id)
  }
}
