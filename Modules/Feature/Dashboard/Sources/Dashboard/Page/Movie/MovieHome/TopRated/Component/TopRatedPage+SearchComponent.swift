import ComposableArchitecture
import SwiftUI

// MARK: - TopRatedPage.SearchComponent

extension TopRatedPage {
  struct SearchComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<TopRatedReducer>
  }
}

extension TopRatedPage.SearchComponent { }

// MARK: - TopRatedPage.SearchComponent + View

extension TopRatedPage.SearchComponent: View {
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

// MARK: - TopRatedPage.SearchComponent.ViewState

extension TopRatedPage.SearchComponent {
  struct ViewState: Equatable { }
}
