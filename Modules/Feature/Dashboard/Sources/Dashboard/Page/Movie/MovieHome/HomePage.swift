import Architecture
import ComposableArchitecture
import LinkNavigator
import SwiftUI

// MARK: - HomePage

struct HomePage {
  @Bindable var store: StoreOf<HomeReducer>

  @Bindable var nowPlayingStore: StoreOf<NowPlayingReducer>
  @Bindable var upcomingStore: StoreOf<UpcomingReducer>
}

// MARK: View

extension HomePage: View {
  var body: some View {
    TabView {
      NowPlayingPage(store: nowPlayingStore)

      UpcomingPage(store: upcomingStore)
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
}
