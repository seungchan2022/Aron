import SwiftUI
import ComposableArchitecture
import DesignSystem

struct GenreListPage {
  @Bindable var store: StoreOf<GenreListReducer>

}

extension GenreListPage: View {
  var body: some View {
    ScrollView {
      LazyVStack(spacing: .zero) {
        ForEach(store.itemList) { item in
          ItemComponent(
            viewState: .init(item: item),
            tapAction: { _ in })
        }
      }
    }
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
