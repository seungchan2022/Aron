import Architecture
import Domain
import Foundation
import LinkNavigator
import My
import Platform

// MARK: - AppContainerMock

// @testable import MyPreview
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
//      MyUseCase: MyUseCasePlatform(),
//      fanClubUseCase: FanClubUseCasePlatform(),
//      movieListUseCase: MovieListUseCasePlatform(),
//      searchUseCase: SearchUseCasePlatform())
//
//    return .init(
//      dependency: sideEffect,
//      navigator: TabLinkNavigatorMock())
//  }
// }

struct AppContainerMock: MyEnvironmentUsable {

  // MARK: Lifecycle

  private init(
    toastViewActionMock: ToastViewActionMock,
    movieUseCaseStub: MovieUseCaseStub,
    movieDetailUseCaseStub: MovieDetailUseCaseStub,
    MyUseCaseStub: MyUseCaseStub,
    fanClubUseCaseStub: FanClubUseCaseStub,
    movieListUseCaseFake: MovieListUseCaseFake,
    searchUseCaseStub: SearchUseCaseStub,
    movieDiscoverUseCaseStub: MovieDiscoverUseCaseStub,
    linkNavigatorMock: TabLinkNavigatorMock)
  {
    self.toastViewActionMock = toastViewActionMock
    self.movieUseCaseStub = movieUseCaseStub
    self.movieDetailUseCaseStub = movieDetailUseCaseStub
    self.MyUseCaseStub = MyUseCaseStub
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
  let MyUseCaseStub: MyUseCaseStub
  let fanClubUseCaseStub: FanClubUseCaseStub
  let movieListUseCaseFake: MovieListUseCaseFake
  let searchUseCaseStub: SearchUseCaseStub
  let movieDiscoverUseCaseStub: MovieDiscoverUseCaseStub
  let linkNavigatorMock: TabLinkNavigatorMock

  var MyUseCase: MyUseCase {
    MyUseCaseStub
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
      MyUseCaseStub: .init(),
      fanClubUseCaseStub: .init(),
      movieListUseCaseFake: .init(),
      searchUseCaseStub: .init(),
      movieDiscoverUseCaseStub: .init(),
      linkNavigatorMock: TabLinkNavigatorMock())
  }
}
