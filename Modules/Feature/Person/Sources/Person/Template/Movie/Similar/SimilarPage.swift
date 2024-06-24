import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - SimilarPage

struct SimilarPage {
  @Bindable var store: StoreOf<SimilarReducer>
}

extension SimilarPage {
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }

  private var navigationTitle: String {
    "Similar Movies"
  }
}

// MARK: View

extension SimilarPage: View {
  var body: some View {
    ScrollView {
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
    .navigationBarTitleDisplayMode(.large)
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem(store.item))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
