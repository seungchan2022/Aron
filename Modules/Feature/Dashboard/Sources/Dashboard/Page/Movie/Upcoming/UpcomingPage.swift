import ComposableArchitecture
import SwiftUI

// MARK: - NowPlayingPage

struct UpcomingPage {
  @Bindable var store: StoreOf<UpcomingReducer>
  
}


// MARK: View

extension UpcomingPage: View {
  var body: some View {
    ScrollView {
      
      SearchComponent(
        viewState: .init(),
        store: store)
      // query에 따라서 보이는 Component 다르게
      
      // MovieItemComponent
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
    .navigationTitle("Upcoming")
    .navigationBarTitleDisplayMode(.inline)
    .scrollDismissesKeyboard(.immediately)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { }) {
          Image(systemName: "rectangle.3.group.fill")
        }
      }
      
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { }) {
          Image(systemName: "gearshape")
        }
      }
    }
    
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}

