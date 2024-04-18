import DesignSystem
import Domain
import SwiftUI

// MARK: - FanClubPage.ItemComponent

extension FanClubPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.FanClub.Item) -> Void
  }
}

extension FanClubPage.ItemComponent {
  private var profileImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.profileImageURL ?? "")"
  }
}

// MARK: - FanClubPage.ItemComponent + View

extension FanClubPage.ItemComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack {
        HStack(spacing: 8) {
          RemoteImage(
            url: profileImageURL,
            placeholder: {
              Image(systemName: "person.fill")
                .resizable()
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv250)).color)
            })
          .clipShape(RoundedRectangle(cornerRadius: 5))
          .frame(width: 80, height: 100)

          VStack(alignment: .leading, spacing: 8) {
            Text(viewState.item.name)
              .foregroundStyle(DesignSystemColor.label(.ocher).color)

            Text(viewState.item.filmList.map { $0.title ?? "" }.joined())
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
              .lineLimit(2)
              .multilineTextAlignment(.leading)
          }

          Spacer()

          Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 8, height: 12)
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)

        Divider()
          .padding(.leading, 72)
      }
    }
  }
}

// MARK: - FanClubPage.ItemComponent.ViewState

extension FanClubPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.FanClub.Item
  }
}
