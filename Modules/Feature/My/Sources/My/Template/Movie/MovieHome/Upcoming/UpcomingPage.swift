import ComposableArchitecture
import DesignSystem
import Functor
import SwiftUI

// MARK: - UpcomingPage

struct UpcomingPage {
  @Bindable var store: StoreOf<UpcomingReducer>

  @State var throttleEvent: ThrottleEvent = .init(value: "", delaySeconds: 1.5)

  @State private var searchResult: SearchResult = .movie

  let isNavigationBarLargeTitle: Bool

}

extension UpcomingPage {
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }

  private var navigationTitle: String {
    "Upcoming"
  }
}

// MARK: View

extension UpcomingPage: View {
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
    .navigationTitle(navigationTitle)
    .navigationBarTitleDisplayMode(isNavigationBarLargeTitle ? .large : .inline)
    .setRequestFlightView(isLoading: isLoading)
    .redacted(reason: isLoading ? .placeholder : [])
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
