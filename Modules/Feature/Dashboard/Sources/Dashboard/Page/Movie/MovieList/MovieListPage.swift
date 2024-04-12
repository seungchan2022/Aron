import ComposableArchitecture
import SwiftUI

// MARK: - MovieListPage

struct MovieListPage {
  @Bindable var store: StoreOf<MovieListReducer>

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
            tapAction: { store.send(.routeToGenreDetail($0))})
        }
      }
    }
    .navigationTitle("MovieList")
    .navigationBarTitleDisplayMode(.large)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { store.send(.routeToMovieHome) }) {
          Image(systemName: "rectangle.grid.1x2")
        }
      }

      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { }) {
          Image(systemName: "gearshape")
        }
      }
    }
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
  }
}
