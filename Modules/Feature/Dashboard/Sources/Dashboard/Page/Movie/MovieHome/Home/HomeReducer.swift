import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SearchResult

enum SearchResult {
  case movie
  case person
}

// MARK: - HomeReducer

@Reducer
struct HomeReducer {
  
  // MARK: Lifecycle
  
  init(
    pageID: String = UUID().uuidString,
    sideEffect: HomeSideEffect)
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
    var searchKeywordItemList: [MovieEntity.Search.Keyword.Item] = []
    var searchPersonItemList: [MovieEntity.Search.Person.Item] = []
    
    var fetchSearchPersonItem: FetchState.Data<MovieEntity.Search.Person.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchMovieItem: FetchState.Data<MovieEntity.Search.Movie.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchKeywordItem: FetchState.Data<MovieEntity.Search.Keyword.Composite?> = .init(isLoading: false, value: .none)
    
    init(id: UUID = UUID()) {
      self.id = id
    }
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
    
    case searchMovie(String)
    case searchKeyword(String)
    case searchPerson(String)
    
    case fetchSearchMovieItem(Result<MovieEntity.Search.Movie.Composite, CompositeErrorRepository>)
    case fetchSearchKeywordItem(Result<MovieEntity.Search.Keyword.Composite, CompositeErrorRepository>)
    case fetchSearchPersonItem(Result<MovieEntity.Search.Person.Composite, CompositeErrorRepository>)
    
    case routeToMovieList
    
    case routeToSearchMovieDetail(MovieEntity.Search.Movie.Item)
    case routeToSearchKeyword(MovieEntity.Search.Keyword.Item)
    case routeToSearchPerson(MovieEntity.Search.Person.Item)
    
    case throwError(CompositeErrorRepository)
  }
  
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestSearchMovie
    case requestSearchKeyword
    case requestSearchPerson
  }
  
  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
        
      case .binding(\.query):
        guard !state.query.isEmpty else {
          state.searchMovieItemList = []
          state.searchKeywordItemList = []
          state.searchPersonItemList = []
          return .none
        }
        
        if state.query != state.fetchSearchMovieItem.value?.request.query {
          state.searchMovieItemList = []
        }
        
        if state.query != state.fetchSearchKeywordItem.value?.request.query {
          state.searchKeywordItemList = []
        }
        
        if state.query != state.fetchSearchPersonItem.value?.request.query {
          state.searchPersonItemList = []
        }
        
        return .none
        
      case .binding:
        return .none
        
      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })
        
      case .searchMovie(let query):
        guard !query.isEmpty else {
          return .none
        }
        
        let page = Int(state.searchMovieItemList.count / 20) + 1
        state.fetchSearchMovieItem.isLoading = true
        return sideEffect
          .searchMovieItem(.init(page: page, query: query))
          .cancellable(pageID: pageID, id: CancelID.requestSearchMovie, cancelInFlight: true)
        
      case .searchKeyword(let query):
        guard !query.isEmpty else {
          return .none
        }
        
        state.fetchSearchKeywordItem.isLoading = true
        return sideEffect.searchKeywordItem(.init(query: query))
          .cancellable(pageID: pageID, id: CancelID.requestSearchKeyword, cancelInFlight: true)
        
      case .searchPerson(let query):
        guard !query.isEmpty else {
          return .none
        }
        
        let page = Int(state.searchPersonItemList.count / 20) + 1
        
        state.fetchSearchPersonItem.isLoading = true
        
        return sideEffect.searchPersonItem(.init(query: query, page: page))
          .cancellable(pageID: pageID, id: CancelID.requestSearchPerson, cancelInFlight: true)
        
      case .fetchSearchMovieItem(let result):
        state.fetchSearchMovieItem.isLoading = false
        
        switch result {
        case .success(let item):
          state.fetchSearchMovieItem.value = item
          state.searchMovieItemList = state.searchMovieItemList.merge(item.response.itemList)
          
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .fetchSearchKeywordItem(let result):
        state.fetchSearchKeywordItem.isLoading = false
        
        switch result {
        case .success(let item):
          state.fetchSearchKeywordItem.value = item
          state.searchKeywordItemList = state.searchKeywordItemList.merge(item.response.itemList)
          
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .fetchSearchPersonItem(let result):
        state.fetchSearchPersonItem.isLoading = false
        
        switch result {
        case .success(let item):
          state.fetchSearchPersonItem.value = item
          state.searchPersonItemList = state.searchPersonItemList.merge(item.response.itemList)
          return .none
          
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .routeToMovieList:
        sideEffect.routeToMovieList()
        return .none
        
      case .routeToSearchMovieDetail(let item):
        sideEffect.routeToSearchMovieDetail(item)
        return .none
        
      case .routeToSearchKeyword(let item):
        sideEffect.routeToSearchKeyword(item)
        return .none
        
      case .routeToSearchPerson(let item):
        sideEffect.routeToSearchPerson(item)
        return .none
        
      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }
  
  // MARK: Private
  
  private let pageID: String
  private let sideEffect: HomeSideEffect
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
