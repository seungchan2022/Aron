import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - HomePage.SearchResultMyComponent

extension HomePage {
  struct SearchResultMyComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Search.Person.Item) -> Void

    @Environment(\.colorScheme) var colorScheme

  }
}

extension HomePage.SearchResultMyComponent {
  private var remoteImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.profileImageURL ?? "")"
  }
}

// MARK: - HomePage.SearchResultMyComponent + View

extension HomePage.SearchResultMyComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      HStack(spacing: 12) {
        RemoteImage(
          url: remoteImageURL,
          placeholder: {
            Image(systemName: "My.fill")
              .resizable()
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv250)).color)
          })
          .clipShape(RoundedRectangle(cornerRadius: 5))
          .frame(width: 80, height: 100)

        VStack(alignment: .leading) {
          Spacer()

          Text(viewState.item.name)
            .font(.system(size: 18))
            .foregroundStyle(DesignSystemColor.label(.ocher).color)
            .multilineTextAlignment(.leading)

          Spacer()

          Text(viewState.item.filmList.map { $0.title ?? "" }.joined())
            .font(.system(size: 16))
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
            .multilineTextAlignment(.leading)
            .lineLimit(3)

          Spacer()
        }

        Spacer()

        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 8, height: 12)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          .padding(.trailing, 16)
      }
    }
  }
}

// MARK: - HomePage.SearchResultMyComponent.ViewState

extension HomePage.SearchResultMyComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Search.Person.Item

  }
}
