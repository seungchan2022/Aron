import ComposableArchitecture
import Foundation

@Reducer
struct NowPlayingReducer {
  private let pageID: String
  private let sideEffect: NowPlayingSideEffect
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: NowPlayingSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }
  
  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    var query = ""
    
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
