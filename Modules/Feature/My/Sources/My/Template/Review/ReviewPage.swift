import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - ReviewPage

struct ReviewPage {
  @Bindable var store: StoreOf<ReviewReducer>
  @Environment(\.colorScheme) var colorScheme

}

extension ReviewPage {
  private var isLoading: Bool {
    store.fetchReviewItem.isLoading
  }

  private var navigationTitle: String {
    "Reviews"
  }
}

// MARK: View

extension ReviewPage: View {
  var body: some View {
    ScrollView {
      if let item = store.fetchReviewItem.value {
        ItemComponent(viewState: .init(item: item))
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv200)).color)
    .navigationTitle(navigationTitle)
    .navigationBarTitleDisplayMode(.large)
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getReview(store.reviewItem))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
