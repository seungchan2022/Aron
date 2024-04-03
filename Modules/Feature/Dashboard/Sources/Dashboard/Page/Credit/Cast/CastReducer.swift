import Architecture
import ComposableArchitecture
import Foundation
import Domain

@Reducer
struct CastReducer {
  private let pageID: String
  private let sideEffect: CastSideEffect
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: CastSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }
  
  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    
    let castItem: MovieEntity.MovieDetail.Credit.Request
    var fetchCastItem: FetchState.Data<MovieEntity.MovieDetail.Credit.Response?> = .init(isLoading: false, value: .none)
    
    init(
      id: UUID = UUID(),
      castItem: MovieEntity.MovieDetail.Credit.Request)
    {
      self.id = id
      self.castItem = castItem
    }
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
    
    case getCastItem(MovieEntity.MovieDetail.Credit.Request)
    case fetchCastItem(Result<MovieEntity.MovieDetail.Credit.Response, CompositeErrorRepository>)
    
    case throwError(CompositeErrorRepository)
  }
  
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestCast
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
        
      case .getCastItem(let requestModel):
        state.fetchCastItem.isLoading = true
        return sideEffect.cast(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestCast, cancelInFlight: true)
        
      case .fetchCastItem(let result):
        print(result)
        state.fetchCastItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchCastItem.value = item
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error) )}
        }
        
      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }
}