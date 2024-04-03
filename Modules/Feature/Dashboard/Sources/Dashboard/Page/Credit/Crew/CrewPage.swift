import ComposableArchitecture
import SwiftUI
import DesignSystem

struct CrewPage {
  @Bindable var store: StoreOf<CrewReducer>
  @Environment(\.colorScheme) var colorScheme

}

extension CrewPage: View {
  var body: some View {
    ScrollView {
      if let item = store.fetchCrewItem.value {
        ItemComponent(
          viewState: .init(item: item),
          tapAction: { })
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv200)).color)
    .navigationTitle("Crew")
    .navigationBarTitleDisplayMode(.large)
    .onAppear {
      store.send(.getCrewItem(store.crewItem))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
