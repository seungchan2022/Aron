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
      NowPlayingPage(store: nowPlayingStore, isNavigationBarLargeTitle: false)

      UpcomingPage(store: upcomingStore, isNavigationBarLargeTitle: false)

      TrendingPage(store: trendingStore, isNavigationBarLargeTitle: false)

      PopularPage(store: popularStore, isNavigationBarLargeTitle: false)

      TopRatedPage(store: topRatedStore, isNavigationBarLargeTitle: false)

      GenreListPage(store: genreListStore)
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
