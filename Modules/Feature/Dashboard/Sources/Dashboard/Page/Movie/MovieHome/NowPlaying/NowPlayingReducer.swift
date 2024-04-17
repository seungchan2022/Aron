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
    
    var searchKeywordItemList: [MovieEntity.Search.Keyword.Item] = []
    var fetchSearchKeywordItem: FetchState.Data<MovieEntity.Search.Keyword.Composite?> = .init(isLoading: false, value: .none)
    
    var searchPersonItemList: [MovieEntity.Search.Person.Item] = []
    var fetchSearchPersonItem: FetchState.Data<MovieEntity.Search.Person.Composite?> = .init(isLoading: false, value: .none)
    
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
    
    case searchKeyword(String)
    case fetchSearchKeywordItem(Result<MovieEntity.Search.Keyword.Composite, CompositeErrorRepository>)
    
    case searchPerson(String)
    case fetchSearchPersonItem(Result<MovieEntity.Search.Person.Composite, CompositeErrorRepository>)
    
    case getItem
    case fetchItem(Result<MovieEntity.Movie.NowPlaying.Response, CompositeErrorRepository>)
    
    case routeToDetail(MovieEntity.Movie.NowPlaying.Item)
    
    case throwError(CompositeErrorRepository)
  }
  
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItemList
    case requestSearchMovie
    case requestSearchKeyword
    case requestSearchPerson
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
          state.searchMovieItemList = []
        }
        
        if
          let totalResultListCount = state.fetchSearchMovieItem.value?.response.totalResultListCount,
          totalResultListCount < state.searchMovieItemList.count
        {
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
          state.searchMovieItemList = state.searchMovieItemList.merge(item.response.itemList)
          
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .searchKeyword(let query):
        guard !query.isEmpty else {
          state.searchKeywordItemList = []
          return .none
        }
        
        if state.query != state.fetchSearchKeywordItem.value?.request.query {
          state.searchKeywordItemList = []
        }
        
        if
          let totalResultListCount = state.fetchSearchKeywordItem.value?.response.totalResultListCount,
          totalResultListCount < state.searchKeywordItemList.count
        {
          return .none
        }
        
        state.fetchSearchKeywordItem.isLoading = true
        return sideEffect.searchKeywordItem(.init(query: query))
          .cancellable(pageID: pageID, id: CancelID.requestSearchKeyword, cancelInFlight: true)
        
      case .fetchSearchKeywordItem(let result):
        state.fetchSearchKeywordItem.isLoading = false
        
        guard !state.query.isEmpty else {
          state.searchMovieItemList = []
          return .none
        }
        
        switch result {
        case .success(let item):
          state.fetchSearchKeywordItem.value = item
          state.searchKeywordItemList = state.searchKeywordItemList.merge(item.response.itemList)
          
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .searchPerson(let query):
        guard !query.isEmpty else {
          state.searchPersonItemList = []
          return .none
        }
        
        if state.query != state.fetchSearchPersonItem.value?.request.query {
          state.searchPersonItemList = []
        }
        
        if let totalResultListCount = state.fetchSearchPersonItem.value?.response.totalResultListCount,
           totalResultListCount < state.searchPersonItemList.count {
          return .none
        }
        
        let page = Int(state.searchPersonItemList.count / 20) + 1
        
        state.fetchSearchPersonItem.isLoading = true
        
        return sideEffect.searchPersonItem(.init(query: query, page: page))
          .cancellable(pageID: pageID, id: CancelID.requestSearchPerson, cancelInFlight: true)
        
      case .fetchSearchPersonItem(let result):
        state.fetchSearchPersonItem.isLoading = false
        
        guard !state.query.isEmpty else {
          state.searchPersonItemList = []
          return .none
        }
        
        switch result {
        case .success(let item):
          state.fetchSearchPersonItem.value = item
          state.searchPersonItemList = state.searchPersonItemList.merge(item.response.itemList)
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


extension [MovieEntity.Search.Movie.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    
    return new
  }
}

extension [MovieEntity.Search.Keyword.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    
    return new
  }
}

extension [MovieEntity.Search.Person.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    
    return new
  }
}
