import ComposableArchitecture
import SwiftUI

// MARK: - FanClubPage

struct FanClubPage {
  @Bindable var store: StoreOf<FanClubReducer>
}

// MARK: View

extension FanClubPage: View {
  var body: some View {
    Text("FanClub")
  }
}
