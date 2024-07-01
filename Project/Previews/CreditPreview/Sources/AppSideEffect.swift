import Architecture
import Credit
import Domain
import Foundation
import LinkNavigator
import Platform

// MARK: - AppSideEffect

struct AppSideEffect: DependencyType, CreditEnvironmentUsable {
  let toastViewModel: ToastViewActionType
  let movieDetailUseCase: MovieDetailUseCase
  let fanClubUseCase: FanClubUseCase
}
