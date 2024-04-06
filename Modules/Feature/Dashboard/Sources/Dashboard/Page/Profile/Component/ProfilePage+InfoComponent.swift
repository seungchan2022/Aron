import DesignSystem
import Domain
import SwiftUI

// MARK: - ProfilePage.InfoComponent

extension ProfilePage {
  struct InfoComponent {
    let viewState: ViewState
  }
}

extension ProfilePage.InfoComponent {
  private var profileImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.profile ?? "")"
  }
}

// MARK: - ProfilePage.InfoComponent + View

extension ProfilePage.InfoComponent: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(alignment: .top) {
        RemoteImage(
          url: profileImageURL,
          placeholder: {
            Rectangle()
              .fill(DesignSystemColor.palette(.gray(.lv250)).color)
          })
          .scaledToFill()
          .frame(width: 100, height: 140)
          .clipShape(RoundedRectangle(cornerRadius: 10))

        VStack(alignment: .leading, spacing: 8) {
          Text("Know for")
            .fontWeight(.bold)

          Text("\(viewState.item.department)")

          Text("\(viewState.item.knownAsList.joined(separator: "\n"))")
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
            .lineLimit(3)
        }
      }
      Divider()

      Text("Place of birth")
        .fontWeight(.bold)

      if let birth = viewState.item.birth {
        Text(birth)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
      }

      Divider()
    }
    .padding(.leading, 16)
  }
}

// MARK: - ProfilePage.InfoComponent.ViewState

extension ProfilePage.InfoComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Person.Info.Response
  }
}
