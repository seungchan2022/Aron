import ComposableArchitecture
import SwiftUI
import DesignSystem

struct CastPage {
  @Bindable var store: StoreOf<CastReducer>
  @Environment(\.colorScheme) var colorScheme

}

extension CastPage: View {
  var body: some View {
    ScrollView {
      if let item = store.fetchCastItem.value {
        ItemComponent(
          viewState: .init(item: item),
          tapAction: { })
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv200)).color)
    .navigationTitle("Cast")
    .navigationBarTitleDisplayMode(.large)
    .onAppear {
      store.send(.getCastItem(store.castItem))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
