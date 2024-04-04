import ComposableArchitecture
import SwiftUI

// MARK: - ProfilePage

struct ProfilePage {
  @Bindable var store: StoreOf<ProfileReducer>
}

// MARK: View

extension ProfilePage: View {
  var body: some View {
    VStack {
      Text("Profile Page")
    }
    .onAppear {
      store.send(.getItem(store.item))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
