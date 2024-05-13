import Architecture
import Foundation
import LinkNavigator
import Platform
import Domain
import Dashboard

//@testable import DashboardPreview
//
//final class AppContainerMock {
//
//  private init(dependency: AppSideEffect, navigator: TabLinkNavigatorMock) {
//    self.dependency = dependency
//    self.navigator = navigator
//  }
//
//  let dependency: AppSideEffect
//  let navigator: TabLinkNavigatorMock
//}
//
//extension AppContainerMock {
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
//}


struct AppContainerMock: DashboardEnvironmentUsable {
  let toastViewModel: ToastViewModel
  let movieUseCaseStub: MovieUseCaseStub
  let movieDetailUseCase: MovieDetailUseCase
  let personUseCase: PersonUseCase
  let fanClubUseCase: FanClubUseCase
  let movieListUseCase: MovieListUseCase
  let searchUseCaseStub: SearchUseCaseStub
  let linkNavigatorMock: TabLinkNavigatorMock
  
  private init(
    toastViewModel: ToastViewModel,
    movieUseCaseStub: MovieUseCaseStub,
    movieDetailUseCase: MovieDetailUseCase,
    personUseCase: PersonUseCase,
    fanClubUseCase: FanClubUseCase,
    movieListUseCase: MovieListUseCase,
    searchUseCaseStub: SearchUseCaseStub,
    linkNavigatorMock: TabLinkNavigatorMock)
  {
    self.toastViewModel = toastViewModel
    self.movieUseCaseStub = movieUseCaseStub
    self.movieDetailUseCase = movieDetailUseCase
    self.personUseCase = personUseCase
    self.fanClubUseCase = fanClubUseCase
    self.movieListUseCase = movieListUseCase
    self.searchUseCaseStub = searchUseCaseStub
    self.linkNavigatorMock = linkNavigatorMock
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
      movieDetailUseCase: MovieDetailUseCasePlatform(),
      personUseCase: PersonUseCasePlatform(),
      fanClubUseCase: FanClubUseCasePlatform(),
      movieListUseCase: MovieListUseCasePlatform(),
      searchUseCaseStub: .init(),
      linkNavigatorMock: TabLinkNavigatorMock())
  }
}
