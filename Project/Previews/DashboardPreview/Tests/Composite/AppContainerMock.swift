import Architecture
import Dashboard
import Domain
import Foundation
import LinkNavigator
import Platform

// MARK: - AppContainerMock

// @testable import DashboardPreview
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

struct AppContainerMock: DashboardEnvironmentUsable {

  // MARK: Lifecycle

  private init(
    toastViewModel: ToastViewModel,
    movieUseCaseStub: MovieUseCaseStub,
    movieDetailUseCaseStub: MovieDetailUseCaseStub,
    personUseCase: PersonUseCase,
    fanClubUseCase: FanClubUseCase,
    movieListUseCase: MovieListUseCase,
    searchUseCaseStub: SearchUseCaseStub,
    movieDiscoverUseCase: MovieDiscoverUseCase,
    linkNavigatorMock: TabLinkNavigatorMock)
  {
    self.toastViewModel = toastViewModel
    self.movieUseCaseStub = movieUseCaseStub
    self.movieDetailUseCaseStub = movieDetailUseCaseStub
    self.personUseCase = personUseCase
    self.fanClubUseCase = fanClubUseCase
    self.movieListUseCase = movieListUseCase
    self.searchUseCaseStub = searchUseCaseStub
    self.movieDiscoverUseCase = movieDiscoverUseCase
    self.linkNavigatorMock = linkNavigatorMock
  }

  // MARK: Internal

  let toastViewModel: ToastViewModel
  let movieUseCaseStub: MovieUseCaseStub
  let movieDetailUseCaseStub: MovieDetailUseCaseStub
  let personUseCase: PersonUseCase
  let fanClubUseCase: FanClubUseCase
  let movieListUseCase: MovieListUseCase
  let searchUseCaseStub: SearchUseCaseStub
  let movieDiscoverUseCase: MovieDiscoverUseCase
  let linkNavigatorMock: TabLinkNavigatorMock
  
  var movieDetailUseCase: MovieDetailUseCase  {
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
      toastViewModel: .init(),
      movieUseCaseStub: MovieUseCaseStub(),
      movieDetailUseCaseStub: .init(),
      personUseCase: PersonUseCasePlatform(),
      fanClubUseCase: FanClubUseCasePlatform(),
      movieListUseCase: MovieListUseCasePlatform(),
      searchUseCaseStub: .init(),
      movieDiscoverUseCase: MovieDiscoverUseCasePlatform(),
      linkNavigatorMock: TabLinkNavigatorMock())
  }
}
