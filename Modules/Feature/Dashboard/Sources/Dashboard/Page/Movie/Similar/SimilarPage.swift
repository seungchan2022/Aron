import SwiftUI
import ComposableArchitecture

struct SimilarPage {
  @Bindable var store: StoreOf<SimilarReducer>
}

extension SimilarPage: View {
  var body: some View {
    Text("Similar Page")
  }
}
