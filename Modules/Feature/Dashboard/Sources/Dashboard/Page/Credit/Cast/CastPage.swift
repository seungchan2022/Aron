import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - CastPage

struct CastPage {
  @Bindable var store: StoreOf<CastReducer>
  @Environment(\.colorScheme) var colorScheme

}

extension CastPage {
  private var isLoading: Bool {
    store.fetchCastItem.isLoading
  }

  private var navigationTitle: String {
    "Cast"
  }
}

// MARK: View

extension CastPage: View {
  var body: some View {
    ScrollView {
      if let item = store.fetchCastItem.value {
        ItemComponent(
          viewState: .init(item: item),
          tapAction: { store.send(.routeToProfile($0)) })
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark
        ? DesignSystemColor.system(.black).color
        : DesignSystemColor.palette(.gray(.lv200)).color)
      .navigationTitle(navigationTitle)
      .navigationBarTitleDisplayMode(.large)
      .setRequestFlightView(isLoading: isLoading)
      .onAppear {
        store.send(.getCastItem(store.castItem))
      }
      .onDisappear {
        store.send(.teardown)
      }
  }
}
