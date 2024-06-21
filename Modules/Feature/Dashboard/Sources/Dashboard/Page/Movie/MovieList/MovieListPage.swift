import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - MovieListPage

struct MovieListPage {
  @Bindable var store: StoreOf<MovieListReducer>
  @Bindable var settingStore: StoreOf<SettingReducer>

  @Environment(\.colorScheme) private var scheme
  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
}

extension MovieListPage {
  private var isLoading: Bool {
    store.fetchNowPlayingItem.isLoading
      || store.fetchUpcomingItem.isLoading
      || store.fetchTrendingItem.isLoading
      || store.fetchPopularItem.isLoading
      || store.fetchTopRatedItem.isLoading
      || store.fetchGenreItem.isLoading
  }

  private var navigationTitle: String {
    "MovieList"
  }
}

// MARK: View

extension MovieListPage: View {
  var body: some View {
    ScrollView {
      VStack {
        if let item = store.fetchNowPlayingItem.value {
          NowPlayingItemComponent(
            viewState: .init(item: item),
            tapSeeAllAction: { store.send(.routeToNowPlaying) },
            tapItemAction: { store.send(.routeToNowPlayingDetail($0)) })
        }

        if let item = store.fetchUpcomingItem.value {
          UpcomingItemComponent(
            viewState: .init(item: item),
            tapSeeAllAction: { store.send(.routeToUpcoming) },
            tapItemAction: { store.send(.routeToUpcomingDetail($0)) })
        }

        if let item = store.fetchTrendingItem.value {
          TrendingItemComponent(
            viewState: .init(item: item),
            tapSeeAllAction: { store.send(.routeToTrending) },
            tapItemAction: { store.send(.routeToTrendingDetail($0)) })
        }

        if let item = store.fetchPopularItem.value {
          PopularItemComponent(
            viewState: .init(item: item),
            tapSeeAllAction: { store.send(.routeToPopular) },
            tapItemAction: { store.send(.routeToPopularDetail($0)) })
        }

        if let item = store.fetchTopRatedItem.value {
          TopRatedItemComponent(
            viewState: .init(item: item),
            tapSeeAllAction: { store.send(.routeToTopRated) },
            tapItemAction: { store.send(.routeToTopRatedDetail($0)) })
        }

        if let item = store.fetchGenreItem.value {
          GenreItemComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToGenreDetail($0)) })
        }
      }
    }
    .navigationTitle(navigationTitle)
    .navigationBarTitleDisplayMode(.large)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { store.send(.routeToMovieHome) }) {
          Image(systemName: "rectangle.grid.1x2")
            .unredacted()
        }
      }

      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { store.isChangeTheme = true }) {
          Image(systemName: "gearshape")
            .unredacted()
        }
      }
    }
    .setRequestFlightView(isLoading: isLoading)
    .redacted(reason: isLoading ? .placeholder : [])
    .onAppear {
      store.send(.getNowPlayingItem)
      store.send(.getUpcomingItem)
      store.send(.getTrendingItem)
      store.send(.getPopularItem)
      store.send(.getTopRatedItem)
      store.send(.getGenreItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
    .preferredColorScheme(userTheme.colorScheme)
    .sheet(isPresented: $store.isChangeTheme) {
      SettingPage(store: settingStore, scheme: scheme)
        .presentationDetents([.height(410)])
        .presentationBackground(.clear)
    }
  }
}
