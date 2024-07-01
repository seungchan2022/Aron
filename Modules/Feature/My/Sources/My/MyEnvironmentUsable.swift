import Architecture
import Domain

public protocol MyEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var movieListUseCase: MovieListUseCase { get }
}
