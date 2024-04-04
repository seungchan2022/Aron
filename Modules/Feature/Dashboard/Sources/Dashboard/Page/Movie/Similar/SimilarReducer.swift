import Architecture
import Domain
import ComposableArchitecture
import Foundation

@Reducer
struct SimilarReducer {
  private let pageID: String
  private let sideEffect: SimilarSideEffect
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: SimilarSideEffect)
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
    
    case throwError(CompositeErrorRepository)
  }
  
  enum CancelID: CaseIterable, Equatable {
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
        
      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }
}
