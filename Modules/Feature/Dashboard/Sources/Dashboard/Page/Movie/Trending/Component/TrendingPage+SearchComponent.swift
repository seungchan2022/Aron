import ComposableArchitecture
import SwiftUI

// MARK: - TrendingPage.SearchComponent

extension TrendingPage {
  struct SearchComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<TrendingReducer>
  }
}

extension TrendingPage.SearchComponent { }

// MARK: - TrendingPage.SearchComponent + View

extension TrendingPage.SearchComponent: View {
  var body: some View {
    VStack(spacing: 16) {
      Divider()
        .padding(.leading, 16)

      HStack(spacing: 16) {
        Image(systemName: "magnifyingglass")
          .resizable()
          .frame(width: 18, height: 18)
          .symbolRenderingMode(.palette)

        TextField(
          "",
          text: self.$store.query,
          prompt: Text("Search any movies or person"))
          .textFieldStyle(.roundedBorder)

        if !store.query.isEmpty {
          Button(action: { self.store.query = "" }) {
            Text("Cancel")
              .foregroundStyle(.red)
          }
        }
      }
      .padding(.horizontal, 16)

      Divider()
        .padding(.leading, 16)
    }
  }
}

// MARK: - TrendingPage.SearchComponent.ViewState

extension TrendingPage.SearchComponent {
  struct ViewState: Equatable { }
}
