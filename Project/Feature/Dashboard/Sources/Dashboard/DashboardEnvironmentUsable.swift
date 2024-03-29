import Architecture
import Domain

public protocol DashboardEnvironmentUsable {
  var toastViewModel: ToastViewModel { get }
  var movieUseCase: MovieUseCase { get }
  var movieDetailUseCase: MovieDetailUseCase { get }
}
