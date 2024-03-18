import ComposableArchitecture
import SwiftUI

// MARK: - DiscoverPage

struct DiscoverPage {
  @Bindable var store: StoreOf<DiscoverReducer>
}

// MARK: View

extension DiscoverPage: View {
  var body: some View {
    Text("DiscoverPage")
  }
}
