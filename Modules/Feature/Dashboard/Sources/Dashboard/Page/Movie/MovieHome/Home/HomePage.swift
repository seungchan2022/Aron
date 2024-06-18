import Architecture
import ComposableArchitecture
import DesignSystem
import Functor
import LinkNavigator
import SwiftUI

// MARK: - HomePage

struct HomePage {
  @Bindable var store: StoreOf<HomeReducer>

  @Bindable var nowPlayingStore: StoreOf<NowPlayingReducer>
  @Bindable var upcomingStore: StoreOf<UpcomingReducer>
  @Bindable var trendingStore: StoreOf<TrendingReducer>
  @Bindable var popularStore: StoreOf<PopularReducer>
  @Bindable var topRatedStore: StoreOf<TopRatedReducer>
  @Bindable var genreListStore: StoreOf<GenreListReducer>
  @Bindable var settingStore: StoreOf<SettingReducer>

  @State var throttleEvent: ThrottleEvent = .init(value: "", delaySeconds: 1.5)

  @State private var searchResult: SearchResult = .movie

  @Environment(\.colorScheme) private var scheme
  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
}

extension HomePage {
  private var isLoading: Bool {
    store.fetchSearchMovieItem.isLoading
    || store.fetchSearchPersonItem.isLoading
    || store.fetchSearchKeywordItem.isLoading
  }
}

// MARK: View

extension HomePage: View {
  var body: some View {
    VStack {
      SearchComponent(
        viewState: .init(),
        store: store)

      if store.query.isEmpty {
        TabView {
          NowPlayingPage(store: nowPlayingStore, isNavigationBarLargeTitle: false)

          UpcomingPage(store: upcomingStore, isNavigationBarLargeTitle: false)

          TrendingPage(store: trendingStore, isNavigationBarLargeTitle: false)

          PopularPage(store: popularStore, isNavigationBarLargeTitle: false)

          TopRatedPage(store: topRatedStore, isNavigationBarLargeTitle: false)

          GenreListPage(store: genreListStore)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
      } else {
        ScrollView {
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
    }
    .scrollDismissesKeyboard(.immediately)
    .preferredColorScheme(userTheme.colorScheme)
    .sheet(isPresented: $store.isChangeTheme) {
      SettingPage(store: settingStore, scheme: scheme)
        .presentationDetents([.height(410)])
        .presentationBackground(.clear)
    }

    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { store.send(.routeToMovieList) }) {
          Image(systemName: "rectangle.3.group.fill")
        }
      }

      ToolbarItem(placement: .topBarTrailing) {
        Button(action: {
          store.isChangeTheme = true
        }) {
          Image(systemName: "gearshape")
        }
      }
    }
    .onChange(of: store.query) { _, new in
      throttleEvent.update(value: new)
    }
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
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
