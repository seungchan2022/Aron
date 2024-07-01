import Architecture
import Domain

public protocol MovieEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var movieUseCase: MovieUseCase { get }
  var movieDetailUseCase: MovieDetailUseCase { get }
  var searchUseCase: SearchUseCase { get }
  var movieDiscoverUseCase: MovieDiscoverUseCase { get }
}
