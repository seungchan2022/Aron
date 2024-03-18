import Architecture
import ComposableArchitecture
import Foundation

@Reducer
struct FanClubReducer {
  private let pageID: String
  private let sideEffect: FanClubSideEffect
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: FanClubSideEffect)
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
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) }
        )
      }
    }
  }
}
