import SwiftUI
import ComposableArchitecture
import Architecture
import LinkNavigator

struct HomePage {
  @Bindable var store: StoreOf<HomeReducer>
  
  @Bindable var nowPlayingStore: StoreOf<NowPlayingReducer>
  @Bindable var upcomingStore: StoreOf<UpcomingReducer>
}

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
