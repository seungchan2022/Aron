import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - CrewPage

struct CrewPage {
  @Bindable var store: StoreOf<CrewReducer>
  @Environment(\.colorScheme) var colorScheme

}

// MARK: View

extension CrewPage: View {
  var body: some View {
    ScrollView {
      if let item = store.fetchCrewItem.value {
        ItemComponent(
          viewState: .init(item: item),
          tapAction: { store.send(.routeToProfile($0)) })
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
