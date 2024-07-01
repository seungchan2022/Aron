import Architecture
import Common
import Credit
import Domain
import Foundation
import LinkNavigator
import Movie
import My
import Platform

// MARK: - AppSideEffect

struct AppSideEffect: DependencyType, CommonEnvironmentUsable, MyEnvironmentUsable, CreditEnvironmentUsable,
  MovieEnvironmentUsable
{
  let toastViewModel: ToastViewActionType
  let movieUseCase: MovieUseCase
  let movieDetailUseCase: MovieDetailUseCase
  let personUseCase: PersonUseCase
  let fanClubUseCase: FanClubUseCase
  let movieListUseCase: MovieListUseCase
  let searchUseCase: SearchUseCase
  let movieDiscoverUseCase: MovieDiscoverUseCase
}
