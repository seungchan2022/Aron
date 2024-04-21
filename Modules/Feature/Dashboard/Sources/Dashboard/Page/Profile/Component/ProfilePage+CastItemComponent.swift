import DesignSystem
import Domain
import SwiftUI

// MARK: - ProfilePage.CastItemComponent

extension ProfilePage {
  struct CastItemComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Person.MovieCredit.CastItem) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension ProfilePage.CastItemComponent {
  private var remoteImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.poster ?? "")"
  }
}

// MARK: - ProfilePage.CastItemComponent + View

extension ProfilePage.CastItemComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack(alignment: .leading) {
        HStack(spacing: 8) {
          RemoteImage(
            url: remoteImageURL,
            placeholder: {
              Image(systemName: "person.fill")
                .resizable()
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv250)).color)
            })
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(width: 80, height: 100)

          VStack(alignment: .leading, spacing: 8) {
            Text(viewState.item.title)
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)
                .multilineTextAlignment(.leading)

            if let character = viewState.item.character {
              Text(character)
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
                .multilineTextAlignment(.leading)
            }
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
      .padding(.horizontal, 16)
    }
  }
}

// MARK: - ProfilePage.CastItemComponent.ViewState

extension ProfilePage.CastItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Person.MovieCredit.CastItem
  }
}
