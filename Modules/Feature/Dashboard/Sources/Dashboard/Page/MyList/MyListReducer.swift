import Architecture
import ComposableArchitecture
import Foundation

@Reducer
struct MyListReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: MyListSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

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

    case routeToNewList
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { _, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .routeToNewList:
        sideEffect.routeToNewList()
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: MyListSideEffect
}