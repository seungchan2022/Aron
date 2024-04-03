import ComposableArchitecture
import SwiftUI

// MARK: - ProfilePage

struct ProfilePage {
  @Bindable var store: StoreOf<ProfileReducer>
}

// MARK: View

extension ProfilePage: View {
  var body: some View {
    Text("Profile Page")
  }
}
