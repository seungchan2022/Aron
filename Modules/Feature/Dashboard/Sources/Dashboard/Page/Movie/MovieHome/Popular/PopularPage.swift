import ComposableArchitecture
import SwiftUI
import DesignSystem

// MARK: - PopularPage

struct PopularPage {
  @Bindable var store: StoreOf<PopularReducer>

  let isNavigationBarLargeTitle: Bool

}

extension PopularPage { 
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension PopularPage: View {
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
    .navigationTitle("Popular")
    .navigationBarTitleDisplayMode(isNavigationBarLargeTitle ? .large : .inline)
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
