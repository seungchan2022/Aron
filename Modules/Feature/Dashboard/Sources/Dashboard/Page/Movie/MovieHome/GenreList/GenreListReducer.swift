import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct GenreListReducer {
  private let pageID: String
  private let sideEffect: GenreListSideEffect
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: GenreListSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }
  
  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    
    var itemList: [MovieEntity.Movie.GenreList.Item] = []
    var fetchItem: FetchState.Data<MovieEntity.Movie.GenreList.Response?> = .init(isLoading: false, value: .none)
    
    init(id: UUID = UUID()) {
      self.id = id
    }
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
    
    case getItem
    case fetchItem(Result<MovieEntity.Movie.GenreList.Response, CompositeErrorRepository>)
    
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
        
      case .getItem:
        state.fetchItem.isLoading = true
        return sideEffect.getItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)
        
      case .fetchItem(let result):
        print(result)
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          state.itemList = state.itemList + item.itemList
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }
}
