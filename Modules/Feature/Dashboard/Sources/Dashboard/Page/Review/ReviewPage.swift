import SwiftUI
import ComposableArchitecture
import DesignSystem

struct ReviewPage {
  @Bindable var store: StoreOf<ReviewReducer>
  @Environment(\.colorScheme) var colorScheme

}

extension ReviewPage: View {
  var body: some View {
    ScrollView {
      if let item = store.fetchReviewItem.value {
        ItemComponent(viewSate: .init(item: item))
      }
    }    
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv200)).color)
    .navigationTitle("Reviews")
    .navigationBarTitleDisplayMode(.large)
    .onAppear {
      store.send(.getReview(store.reviewItem))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
