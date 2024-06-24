import Architecture
import Domain
import Foundation
import LinkNavigator
import Person
import Platform

// MARK: - AppSideEffect

struct AppSideEffect: DependencyType, PersonEnvironmentUsable {
  let toastViewModel: ToastViewActionType
  let movieUseCase: MovieUseCase
  let movieDetailUseCase: MovieDetailUseCase
  let personUseCase: PersonUseCase
  let fanClubUseCase: FanClubUseCase
  let movieListUseCase: MovieListUseCase
  let searchUseCase: SearchUseCase
  let movieDiscoverUseCase: MovieDiscoverUseCase
}
