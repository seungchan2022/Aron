import Architecture
import ComposableArchitecture
import Foundation

@Reducer
struct NewListReducer {
  private let pageID: String
  private let sideEffect: NewListSideEffect
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: NewListSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }
  
  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    
    init(id: UUID = UUID()) {
      self.id = id
    }
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
    
    case routeToBack
  }
  
  enum CancelID: Equatable, CaseIterable {
    case teardown
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
        
      case .routeToBack:
        sideEffect.routeToBack()
        return .none
      }
    }
  }
}
