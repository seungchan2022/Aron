import Architecture
import Domain

public protocol CommonEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var movieDetailUseCase: MovieDetailUseCase { get }
  var personUseCase: PersonUseCase { get }
  var movieListUseCase: MovieListUseCase { get }
}
