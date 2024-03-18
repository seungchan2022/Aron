import SwiftUI
import ComposableArchitecture

struct MyListPage {
  @Bindable var store: StoreOf<MyListReducer>
}

extension MyListPage: View {
  var body: some View {
    Text("MyListPage")
  }
}
