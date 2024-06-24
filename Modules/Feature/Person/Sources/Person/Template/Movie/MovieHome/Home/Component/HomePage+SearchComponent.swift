import ComposableArchitecture
import SwiftUI

// MARK: - HomePage.SearchComponent

extension HomePage {
  struct SearchComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<HomeReducer>
  }
}

extension HomePage.SearchComponent { }

// MARK: - HomePage.SearchComponent + View

extension HomePage.SearchComponent: View {
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

// MARK: - HomePage.SearchComponent.ViewState

extension HomePage.SearchComponent {
  struct ViewState: Equatable { }
}
