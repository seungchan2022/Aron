import ComposableArchitecture
import SwiftUI

// MARK: - TopRatedPage

struct TopRatedPage {
  @Bindable var store: StoreOf<TopRatedReducer>

  let isNavigationBarLargeTitle: Bool

}

extension TopRatedPage { }

// MARK: View

extension TopRatedPage: View {
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 16) {
        ForEach(store.itemList) { item in
          ItemComponent(
            viewState: .init(item: item),
            tapAction: {
              store.send(.routeToDetail($0))
            })
            .onAppear {
              guard let last = store.itemList.last, last.id == item.id else { return }
              guard !store.fetchItem.isLoading else { return }
              store.send(.getItem)
            }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 16)
      .padding(.top, 12)
    }
    .navigationTitle("Top Rated")
    .navigationBarTitleDisplayMode(isNavigationBarLargeTitle ? .large : .inline)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
