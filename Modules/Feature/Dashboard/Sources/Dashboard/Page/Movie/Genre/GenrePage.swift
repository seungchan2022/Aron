import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - GenrePage

struct GenrePage {
  @Bindable var store: StoreOf<GenreReducer>

}

extension GenrePage {
  private var navigationTitle: String {
    store.item.name
  }
  
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension GenrePage: View {
  var body: some View {
    ScrollView {
      // MovieItemComponent
      Divider()
        .padding(.leading, 16)

      if let itemList = store.fetchItem.value?.itemList {
        LazyVStack(spacing: 16) {
          ForEach(itemList) { item in
            ItemComponent(
              viewState: .init(item: item),
              tapAction: {
                store.send(.routeToDetail($0))
              })
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.top, 12)
      }
    }
    .navigationTitle(navigationTitle)
    .navigationBarTitleDisplayMode(.inline)
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem(store.item))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
