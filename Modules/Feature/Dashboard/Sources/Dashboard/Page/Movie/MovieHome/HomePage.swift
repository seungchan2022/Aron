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
        .navigationTitle("Now Playing")
        .navigationBarTitleDisplayMode(.inline)
      
      UpcomingPage(store: upcomingStore)
        .navigationTitle("Upcoming")
        .navigationBarTitleDisplayMode(.inline)
      
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { }) {
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
