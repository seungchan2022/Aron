import Architecture
import Domain
import Foundation
import LinkNavigator
import Movie
import Platform

// MARK: - AppSideEffect

struct AppSideEffect: DependencyType, MovieEnvironmentUsable {
  let toastViewModel: ToastViewActionType
  let movieUseCase: MovieUseCase
  let movieDetailUseCase: MovieDetailUseCase
  let searchUseCase: SearchUseCase
  let movieDiscoverUseCase: MovieDiscoverUseCase
}
