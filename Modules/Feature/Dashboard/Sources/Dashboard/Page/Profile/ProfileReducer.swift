import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct ProfileReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: ProfileSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    
    var isShowingReadMore = false
    
    let item: MovieEntity.Person.Info.Request
    let profileImageItem: MovieEntity.Person.Image.Request
        
    let movieCreditItem: MovieEntity.Person.MovieCredit.Request

    var fetchItem: FetchState.Data<MovieEntity.Person.Info.Response?> = .init(isLoading: false, value: .none)
    var fetchProfileImageItem: FetchState.Data<MovieEntity.Person.Image.Response?> = .init(isLoading: false, value: .none)
    var fetchMovieCreditItem: FetchState.Data<MovieEntity.Person.MovieCredit.Response?> = .init(isLoading: false, value: .none)

    init(
      id: UUID = UUID(),
      item: MovieEntity.Person.Info.Request,
      profileImageItem: MovieEntity.Person.Image.Request,
      movieCreditItem: MovieEntity.Person.MovieCredit.Request)
    {
      self.id = id
      self.item = item
      self.profileImageItem = profileImageItem
      self.movieCreditItem = movieCreditItem
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem(MovieEntity.Person.Info.Request)
    case getProfileImage(MovieEntity.Person.Image.Request)
    case getMovieCreditItem(MovieEntity.Person.MovieCredit.Request)

    case fetchItem(Result<MovieEntity.Person.Info.Response, CompositeErrorRepository>)
    case fetchProfileImage(Result<MovieEntity.Person.Image.Response, CompositeErrorRepository>)
    case fetchMovieCreditItem(Result<MovieEntity.Person.MovieCredit.Response, CompositeErrorRepository>)
    
    case routeToCastDetail(MovieEntity.Person.MovieCredit.CastItem)
    case routeToCrewDetail(MovieEntity.Person.MovieCredit.CrewItem)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItem
    case requestProfileImage
    case requestMovieCreditItem
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getItem(let requestModel):
        state.fetchItem.isLoading = true
        return sideEffect.item(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)

      case .getProfileImage(let requestModel):
        state.fetchProfileImageItem.isLoading = true
        return sideEffect.profileImage(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestProfileImage, cancelInFlight: true)
        
      case .getMovieCreditItem(let requestModel):
        state.fetchMovieCreditItem.isLoading = true
        return sideEffect.movieCredit(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestMovieCreditItem, cancelInFlight: true)

      case .fetchItem(let result):
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchProfileImage(let result):
        state.fetchProfileImageItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchProfileImageItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

        
      case .fetchMovieCreditItem(let result):
        state.fetchMovieCreditItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchMovieCreditItem.value = item
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .routeToCastDetail(let item):
        sideEffect.routeToCastDetail(item)
        return .none
        
      case .routeToCrewDetail(let item):
        sideEffect.routeToCrewDetail(item)
        return .none
        
      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: ProfileSideEffect
}
