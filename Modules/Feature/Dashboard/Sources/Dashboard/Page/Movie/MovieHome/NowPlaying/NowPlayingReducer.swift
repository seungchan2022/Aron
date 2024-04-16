import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct NowPlayingReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: NowPlayingSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID
    var query = ""
    
    var searchMovieItemList: [MovieEntity.Search.Movie.Item] = []
    
    var fetchSearchMovieItem: FetchState.Data<MovieEntity.Search.Movie.Composite?> = .init(isLoading: false, value: .none)
    
    var itemList: [MovieEntity.Movie.NowPlaying.Item] = []
    var fetchItem: FetchState.Data<MovieEntity.Movie.NowPlaying.Response?> = .init(isLoading: false, value: .none)

    init(id: UUID = UUID()) {
      self.id = id
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case searchMovie(String)
    case fetchSearchMovieItem(Result<MovieEntity.Search.Movie.Composite, CompositeErrorRepository>)
    
    case getItem
    case fetchItem(Result<MovieEntity.Movie.NowPlaying.Response, CompositeErrorRepository>)

    case routeToDetail(MovieEntity.Movie.NowPlaying.Item)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItemList
    case requestSearchMovie
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

      case .searchMovie(let query):
        guard !query.isEmpty else {
          state.searchMovieItemList = []
          return .none
        }
          
        if state.query != state.fetchSearchMovieItem.value?.request.query {
          state.searchMovieItemList  = []
        }
        
        if let totalResultListCount = state.fetchSearchMovieItem.value?.response.totalResultListCount, totalResultListCount < state.searchMovieItemList.count {
          return .none
        }
        
        let page = Int(state.searchMovieItemList.count / 20) + 1
        
        state.fetchSearchMovieItem.isLoading = true
        return sideEffect.searchMovieItem(.init(page: page, query: query))
          .cancellable(pageID: pageID, id: CancelID.requestSearchMovie, cancelInFlight: true)
        
      case .fetchSearchMovieItem(let result):
        state.fetchSearchMovieItem.isLoading = false
        
        guard !state.query.isEmpty else {
          state.searchMovieItemList = []
          return .none
        }
        
        switch result {
        case .success(let item):
          state.fetchSearchMovieItem.value = item
          state.searchMovieItemList = state.searchMovieItemList +  item.response.itemList
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
        
      case .getItem:
        let page = Int(state.itemList.count / 20) + 1
        state.fetchItem.isLoading = true
        return sideEffect.getItem(.init(page: page))
          .cancellable(pageID: pageID, id: CancelID.requestItemList, cancelInFlight: true)

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

  // MARK: Private

  private let pageID: String
  private let sideEffect: NowPlayingSideEffect
}
