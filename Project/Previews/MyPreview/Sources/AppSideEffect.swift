import Architecture
import Domain
import Foundation
import LinkNavigator
import My
import Platform

// MARK: - AppSideEffect

struct AppSideEffect: DependencyType, MyEnvironmentUsable {
  let toastViewModel: ToastViewActionType
  let movieListUseCase: MovieListUseCase
}
