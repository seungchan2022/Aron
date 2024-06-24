import Architecture
import Domain

public protocol MyEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var movieUseCase: MovieUseCase { get }
  var movieDetailUseCase: MovieDetailUseCase { get }
  var personUseCase: PersonUseCase { get }
  var fanClubUseCase: FanClubUseCase { get }
  var movieListUseCase: MovieListUseCase { get }
  var searchUseCase: SearchUseCase { get }
  var movieDiscoverUseCase: MovieDiscoverUseCase { get }
}
