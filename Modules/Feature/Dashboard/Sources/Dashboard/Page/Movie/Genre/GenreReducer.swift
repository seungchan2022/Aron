import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct GenreReducer {
  private let pageID: String
  private let sideEffect: GenreSideEffect
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: GenreSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }
  
  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    
    let item: MovieEntity.MovieDetail.Genre.Request
    
    var fetchItem: FetchState.Data<MovieEntity.MovieDetail.Genre.Response?> = .init(isLoading: false, value: .none)
    
    init(
      id: UUID = UUID(),
      item: MovieEntity.MovieDetail.Genre.Request) 
    {
      self.id = id
      self.item = item
    }
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
    
    case getItem(MovieEntity.MovieDetail.Genre.Request)
    case fetchItem(Result<MovieEntity.MovieDetail.Genre.Response, CompositeErrorRepository>)
    
    case routeToDetail(MovieEntity.MovieDetail.Genre.Response.Item)
    
    case throwError(CompositeErrorRepository)
  }
  
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItem
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
        
      case .getItem(let request):
        state.fetchItem.isLoading = true
        return sideEffect.getItem(request)
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)
        
      case .fetchItem(let result):
        print(result)
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .routeToDetail(let item):
        sideEffect.routeToDetail(item)
        return .none
        
      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }
}
