import ComposableArchitecture
import SwiftUI

// MARK: - MovieDetailPage

struct MovieDetailPage {
  @Bindable var store: StoreOf<MovieDetailReducer>
}

// MARK: View

extension MovieDetailPage: View {
  var body: some View {
    Text("MovieDetailPage")
  }
}
