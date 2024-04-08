import ComposableArchitecture
import SwiftUI

// MARK: - RecommendedPage

struct RecommendedPage {
  @Bindable var store: StoreOf<RecommendedReducer>
}

// MARK: View

extension RecommendedPage: View {
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
    .navigationTitle("Recommended Movies")
    .navigationBarTitleDisplayMode(.large)
    .onAppear {
      store.send(.getItem(store.item))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}