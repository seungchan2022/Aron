import SwiftUI
import ComposableArchitecture

struct NowPlayingPage {
  @Bindable var store: StoreOf<NowPlayingReducer>
}

extension NowPlayingPage: View {
  var body: some View {
    Text("NowPlayingPage")
  }
}
