import DesignSystem
import Domain
import SwiftUI

// MARK: - ProfilePage.CrewItemComponent

extension ProfilePage {
  struct CrewItemComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Person.MovieCredit.CrewItem) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension ProfilePage.CrewItemComponent {
  private var remoteImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.poster ?? "")"
  }
}

// MARK: - ProfilePage.CrewItemComponent + View

extension ProfilePage.CrewItemComponent: View {
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

            if let department = viewState.item.department {
              Text(department)
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

// MARK: - ProfilePage.CrewItemComponent.ViewState

extension ProfilePage.CrewItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Person.MovieCredit.CrewItem
  }
}
