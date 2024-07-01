import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - GenreListPage

struct GenreListPage {
  @Bindable var store: StoreOf<GenreListReducer>

}

extension GenreListPage {
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension GenreListPage: View {
  var body: some View {
    ScrollView {
      LazyVStack(spacing: .zero) {
        ForEach(store.itemList) { item in
          ItemComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToDetail($0)) })
        }
      }
    }
    .navigationTitle("Genre")
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
