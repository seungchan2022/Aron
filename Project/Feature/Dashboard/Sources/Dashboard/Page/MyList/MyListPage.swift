import ComposableArchitecture
import SwiftUI

// MARK: - MyListPage

struct MyListPage {
  @Bindable var store: StoreOf<MyListReducer>
}

// MARK: View

extension MyListPage: View {
  var body: some View {
    Text("MyListPage")
  }
}
