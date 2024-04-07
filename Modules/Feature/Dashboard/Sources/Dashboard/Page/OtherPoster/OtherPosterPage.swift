import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - OtherPosterPage

struct OtherPosterPage {
  @Bindable var store: StoreOf<OtherPosterReducer>
}

// MARK: View

extension OtherPosterPage: View {
  var body: some View {
    VStack {
      if let item = store.fetchItem.value {
        ItemComponent(
          viewState: .init(item: item.imageBucket),
          tapBackAction: { store.send(.routeToBack) })
      }
    }
    .onAppear {
      store.send(.getItem(store.item))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
