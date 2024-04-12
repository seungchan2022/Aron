import SwiftUI
import ComposableArchitecture
import DesignSystem

struct GenrePage {
  @Bindable var store: StoreOf<GenreReducer>

}

extension GenrePage {
//  private var navigationTitle: String {
//
//  }
}

extension GenrePage: View {
  var body: some View {
    ScrollView {
      // MovieItemComponent
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
    .navigationTitle("")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      store.send(.getItem(store.item))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}