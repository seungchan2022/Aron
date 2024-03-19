import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct MovieDetailReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: MovieDetailSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable {

    // MARK: Lifecycle

    init(
      id: UUID = UUID(),
      item: MovieEntity.MovieDetail.MovieCard.Request,
      reviewItem: MovieEntity.MovieDetail.Review.Request,
      creditItem: MovieEntity.MovieDetail.Credit.Request)
    {
      self.id = id
      self.item = item
      self.reviewItem = reviewItem
      self.creditItem = creditItem
    }

    // MARK: Internal

    let id: UUID
    let item: MovieEntity.MovieDetail.MovieCard.Request
    let reviewItem: MovieEntity.MovieDetail.Review.Request
    let creditItem: MovieEntity.MovieDetail.Credit.Request

    var fetchDetailItem: FetchState.Data<MovieEntity.MovieDetail.MovieCard.Response?> = .init(isLoading: false, value: .none)
    var fetchReviewItem: FetchState.Data<MovieEntity.MovieDetail.Review.Response?> = .init(isLoading: false, value: .none)
    var fetchCreditItem: FetchState.Data<MovieEntity.MovieDetail.Credit.Response?> = .init(isLoading: false, value: .none)

  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getDetail
    case getReview
    case getCredit
    case fetchDetailItem(Result<MovieEntity.MovieDetail.MovieCard.Response, CompositeErrorRepository>)
    case fetchReviewItem(Result<MovieEntity.MovieDetail.Review.Response, CompositeErrorRepository>)
    case fetchCreditItem(Result<MovieEntity.MovieDetail.Credit.Response, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestDetail
    case requestReview
    case requestCredit
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

      case .getDetail:
        state.fetchDetailItem.isLoading = true
        return sideEffect.detail(state.item)
          .cancellable(pageID: pageID, id: CancelID.requestDetail, cancelInFlight: true)

      case .getReview:
        state.fetchReviewItem.isLoading = true
        return sideEffect.review(state.reviewItem)
          .cancellable(pageID: pageID, id: CancelID.requestReview, cancelInFlight: true)

      case .getCredit:
        state.fetchCreditItem.isLoading = true
        return sideEffect.credit(state.creditItem)
          .cancellable(pageID: pageID, id: CancelID.requestCredit, cancelInFlight: true)

      case .fetchDetailItem(let result):
        state.fetchDetailItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchDetailItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchReviewItem(let result):
        state.fetchReviewItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchReviewItem.value = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchCreditItem(let result):
        state.fetchCreditItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchCreditItem.value = item
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

  // MARK: Private

  private let pageID: String
  private let sideEffect: MovieDetailSideEffect
}
