import Architecture
import ComposableArchitecture
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
}

// MARK: View

extension HomePage: View {
  var body: some View {
    TabView {
      GenreListPage(store: genreListStore)
        .navigationTitle("GenreList")
        .navigationBarTitleDisplayMode(.inline)
      
      NowPlayingPage(store: nowPlayingStore)
        .navigationTitle("Now Playing")
        .navigationBarTitleDisplayMode(.inline)

      UpcomingPage(store: upcomingStore)
        .navigationTitle("Upcoming")
        .navigationBarTitleDisplayMode(.inline)

      TrendingPage(store: trendingStore)
        .navigationTitle("Trending")
        .navigationBarTitleDisplayMode(.inline)

      PopularPage(store: popularStore)
        .navigationTitle("Popular")
        .navigationBarTitleDisplayMode(.inline)

      TopRatedPage(store: topRatedStore)
        .navigationTitle("Top Rated")
        .navigationBarTitleDisplayMode(.inline)
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { store.send(.routeToMovieList) }) {
          Image(systemName: "rectangle.3.group.fill")
        }
      }

      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { }) {
          Image(systemName: "gearshape")
        }
      }
    }
  }
}
