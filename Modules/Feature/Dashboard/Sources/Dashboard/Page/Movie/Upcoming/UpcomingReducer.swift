import Architecture
import Domain
import ComposableArchitecture
import Foundation

@Reducer
struct UpcomingReducer {
  private let pageID: String
  private let sideEffect: UpcomingSideEffect
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: UpcomingSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }
  
  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    var query = ""
    var itemList: [MovieEntity.Movie.Upcoming.Item] = []
    var fetchItem: FetchState.Data<MovieEntity.Movie.Upcoming.Response?> = .init(isLoading: false, value: .none)
    
    init(id: UUID = UUID()) {
      self.id = id
    }
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
    
    case getItem
    case fetchItem(Result<MovieEntity.Movie.Upcoming.Response, CompositeErrorRepository>)
    
    case routeToDetail(MovieEntity.Movie.Upcoming.Item)
    
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
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0 )})
        
      case .getItem:
        state.fetchItem.isLoading = true
        let page = Int(state.itemList.count / 20) + 1
        return sideEffect.getItem(.init(page: page))
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)
        
      case .fetchItem(let result):
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          state.itemList = state.itemList + item.itemList
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
