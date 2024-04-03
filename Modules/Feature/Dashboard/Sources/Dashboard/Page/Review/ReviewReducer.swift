import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct ReviewReducer {
  private let pageID: String
  private let sideEffect: ReviewSideEffect
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: ReviewSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }
  
  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    let reviewItem: MovieEntity.MovieDetail.Review.Request
    var fetchReviewItem: FetchState.Data<MovieEntity.MovieDetail.Review.Response?> = .init(isLoading: false, value: .none)
    
    init(
      id: UUID = UUID(),
      reviewItem: MovieEntity.MovieDetail.Review.Request) 
    {
      self.id = id
      self.reviewItem = reviewItem
    }
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getReview(MovieEntity.MovieDetail.Review.Request)
    case fetchReviewItem(Result<MovieEntity.MovieDetail.Review.Response, CompositeErrorRepository>)
    
    case throwError(CompositeErrorRepository)
  }
  
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestReview
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

      case .getReview(let requestModel):
        state.fetchReviewItem.isLoading = true
        return sideEffect.review(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestReview, cancelInFlight: true)
        
      case .fetchReviewItem(let result):
        state.fetchReviewItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchReviewItem.value = item
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
