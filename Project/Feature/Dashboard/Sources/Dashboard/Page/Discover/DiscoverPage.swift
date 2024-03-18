import SwiftUI
import ComposableArchitecture

struct DiscoverPage {
  @Bindable var store: StoreOf<DiscoverReducer>
}

extension DiscoverPage: View {
  var body: some View {
    Text("DiscoverPage")
  }
}
