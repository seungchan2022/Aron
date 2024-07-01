import Architecture
import Domain

public protocol CreditEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var movieDetailUseCase: MovieDetailUseCase { get }
  var fanClubUseCase: FanClubUseCase { get }
}
