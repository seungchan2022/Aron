import Architecture
import Domain
import Foundation
import LinkNavigator
import Person
import Platform

// MARK: - AppContainerMock

// @testable import PersonPreview
//
// final class AppContainerMock {
//
//  private init(dependency: AppSideEffect, navigator: TabLinkNavigatorMock) {
//    self.dependency = dependency
//    self.navigator = navigator
//  }
//
//  let dependency: AppSideEffect
//  let navigator: TabLinkNavigatorMock
// }
//
// extension AppContainerMock {
//  class func build() -> AppContainerMock {
//    let sideEffect = AppSideEffect(
//      toastViewModel: .init(),
//      movieUseCase: MovieUseCaseStub(),
//      movieDetailUseCase: MovieDetailUseCasePlatform(),
//      personUseCase: PersonUseCasePlatform(),
//      fanClubUseCase: FanClubUseCasePlatform(),
//      movieListUseCase: MovieListUseCasePlatform(),
//      searchUseCase: SearchUseCasePlatform())
//
//    return .init(
//      dependency: sideEffect,
//      navigator: TabLinkNavigatorMock())
//  }
// }

struct AppContainerMock: PersonEnvironmentUsable {

  // MARK: Lifecycle

  private init(
    toastViewActionMock: ToastViewActionMock,
    movieUseCaseStub: MovieUseCaseStub,
    movieDetailUseCaseStub: MovieDetailUseCaseStub,
    personUseCaseStub: PersonUseCaseStub,
    fanClubUseCaseStub: FanClubUseCaseStub,
    movieListUseCaseFake: MovieListUseCaseFake,
    searchUseCaseStub: SearchUseCaseStub,
    movieDiscoverUseCaseStub: MovieDiscoverUseCaseStub,
    linkNavigatorMock: TabLinkNavigatorMock)
  {
    self.toastViewActionMock = toastViewActionMock
    self.movieUseCaseStub = movieUseCaseStub
    self.movieDetailUseCaseStub = movieDetailUseCaseStub
    self.personUseCaseStub = personUseCaseStub
    self.fanClubUseCaseStub = fanClubUseCaseStub
    self.movieListUseCaseFake = movieListUseCaseFake
    self.searchUseCaseStub = searchUseCaseStub
    self.movieDiscoverUseCaseStub = movieDiscoverUseCaseStub
    self.linkNavigatorMock = linkNavigatorMock
  }

  // MARK: Internal

  let toastViewActionMock: ToastViewActionMock
  let movieUseCaseStub: MovieUseCaseStub
  let movieDetailUseCaseStub: MovieDetailUseCaseStub
  let personUseCaseStub: PersonUseCaseStub
  let fanClubUseCaseStub: FanClubUseCaseStub
  let movieListUseCaseFake: MovieListUseCaseFake
  let searchUseCaseStub: SearchUseCaseStub
  let movieDiscoverUseCaseStub: MovieDiscoverUseCaseStub
  let linkNavigatorMock: TabLinkNavigatorMock

  var personUseCase: PersonUseCase {
    personUseCaseStub
  }

  var fanClubUseCase: FanClubUseCase {
    fanClubUseCaseStub
  }

  var movieDiscoverUseCase: MovieDiscoverUseCase {
    movieDiscoverUseCaseStub
  }

  var toastViewModel: ToastViewActionType {
    toastViewActionMock
  }

  var movieListUseCase: MovieListUseCase {
    movieListUseCaseFake
  }

  var movieDetailUseCase: MovieDetailUseCase {
    movieDetailUseCaseStub
  }

  var searchUseCase: SearchUseCase {
    searchUseCaseStub
  }

  var linkNavigator: RootNavigatorType {
    linkNavigatorMock
  }

  var movieUseCase: MovieUseCase {
    movieUseCaseStub
  }
}

extension AppContainerMock {
  static func generate() -> AppContainerMock {
    .init(
      toastViewActionMock: .init(),
      movieUseCaseStub: .init(),
      movieDetailUseCaseStub: .init(),
      personUseCaseStub: .init(),
      fanClubUseCaseStub: .init(),
      movieListUseCaseFake: .init(),
      searchUseCaseStub: .init(),
      movieDiscoverUseCaseStub: .init(),
      linkNavigatorMock: TabLinkNavigatorMock())
  }
}
