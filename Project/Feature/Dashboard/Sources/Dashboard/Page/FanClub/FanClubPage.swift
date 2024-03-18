import SwiftUI
import ComposableArchitecture

struct FanClubPage {
  @Bindable var store: StoreOf<FanClubReducer>
}

extension FanClubPage: View {
  var body: some View {
    Text("FanClub")
  }
}
