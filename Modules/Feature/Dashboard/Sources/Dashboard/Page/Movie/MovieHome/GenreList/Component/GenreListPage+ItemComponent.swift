import DesignSystem
import Domain
import SwiftUI

// MARK: - GenreListPage.ItemComponent

extension GenreListPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Movie.GenreList.Item) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension GenreListPage.ItemComponent { }

// MARK: - GenreListPage.ItemComponent + View

extension GenreListPage.ItemComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack {
        HStack {
          Text(viewState.item.name)
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)

          Spacer()

          Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 8, height: 12)
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
            .padding(.trailing, 16)
        }

        Divider()
      }
      .padding(.leading, 16)
    }
    .padding(4)
  }
}

// MARK: - GenreListPage.ItemComponent.ViewState

extension GenreListPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Movie.GenreList.Item
  }
}
