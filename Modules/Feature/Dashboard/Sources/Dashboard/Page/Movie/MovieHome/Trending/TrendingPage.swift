import ComposableArchitecture
import DesignSystem
import Functor
import SwiftUI

// MARK: - NowPlayingPage

struct TrendingPage {
  @Bindable var store: StoreOf<TrendingReducer>
  
  @State var throttleEvent: ThrottleEvent = .init(value: "", delaySeconds: 1.5)
  
  @State private var searchResult: SearchResult = .movie
  
  let isNavigationBarLargeTitle: Bool
  
}

extension TrendingPage { }

// MARK: View

extension TrendingPage: View {
  var body: some View {
    ScrollView {
      SearchComponent(
        viewState: .init(),
        store: store)
            
      if store.query.isEmpty {
        LazyVStack(spacing: 16) {
          ForEach(store.itemList) { item in
            ItemComponent(
              viewState: .init(item: item),
              tapAction: {
                store.send(.routeToDetail($0))
              })
            .onAppear {
              guard let last = store.itemList.last, last.id == item.id else { return }
              guard !store.fetchItem.isLoading else { return }
              store.send(.getItem)
            }
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.top, 12)
      } else {
        VStack {
          Picker(
            "",
            selection: self.$searchResult)
          {
            Text("Movie")
              .tag(SearchResult.movie)
            
            Text("People")
              .tag(SearchResult.person)
          }
          .pickerStyle(.segmented)
          .padding(.horizontal, 16)
          
          Divider()
            .padding(.leading, 16)
          
          switch self.searchResult {
          case .movie: // Keyword + Movie
            
            LazyVStack(alignment: .leading) {
              Text("Keywords")
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                .padding(.top, 16)
              
              ForEach(store.searchKeywordItemList.prefix(5)) { item in
                SearchResultKeywordComponent(
                  viewState: .init(item: item),
                  tapAction: { store.send(.routeToSearchKeyword($0)) })
                Divider()
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            
            // Movie
            LazyVStack(alignment: .leading, spacing: 16) {
              Text("Result for \(store.query)")
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                .padding(.top, 16)
              
              Divider()
                .padding(.top, -8)
              
              if store.searchMovieItemList.isEmpty {
                Text("No Result")
              }
              
              ForEach(store.searchMovieItemList) { item in
                SearchResultMovieComponent(
                  viewState: .init(item: item),
                  tapAction: { store.send(.routeToSearchMovieDetail($0)) })
                .onAppear {
                  guard let last = store.searchMovieItemList.last, last.id == item.id else { return }
                  guard !store.fetchSearchMovieItem.isLoading else { return }
                  store.send(.searchMovie(store.query))
                }
              }
            }
            .padding(.leading, 16)
            
          case .person:
            LazyVStack(alignment: .leading, spacing: 16) {
              
              if store.searchPersonItemList.isEmpty {
                Text("No Result")
              }

              ForEach(store.searchPersonItemList) { item in
                SearchResultPersonComponent(
                  viewState: .init(item: item),
                  tapAction: { store.send(.routeToSearchPerson($0)) })
                .onAppear {
                  guard let last = store.searchPersonItemList.last, last.id == item.id else { return }
                  guard !store.fetchSearchPersonItem.isLoading else { return }
                  store.send(.searchPerson(store.query))
                }
                
                if store.searchPersonItemList.last != item {
                  Divider()
                    .padding(.leading, 80)
                    .padding(.top, 12)
                }
              }
            }
            .padding(.vertical, 12)
            .padding(.leading, 16)
          }
        }
      }
    }
    .navigationTitle("Trending")
    .navigationBarTitleDisplayMode(isNavigationBarLargeTitle ? .large : .inline)
    .scrollDismissesKeyboard(.immediately)
    .onChange(of: store.query) { _, new in
      throttleEvent.update(value: new)
    }
    .onAppear {
      store.send(.getItem)
      
      throttleEvent.apply { _ in
        store.send(.searchMovie(store.query))
        store.send(.searchKeyword(store.query))
        store.send(.searchPerson(store.query))
      }
    }
    .onDisappear {
      throttleEvent.reset()
      store.send(.teardown)
    }
  }
}

// MARK: - SearchResult

fileprivate enum SearchResult {
  case movie
  case person
}
