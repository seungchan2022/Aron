import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - ProfilePage.InfoComponent

extension ProfilePage {
  struct InfoComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<ProfileReducer>
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
            Image(systemName: "person.fill")
              .resizable()
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv250)).color)
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
        .padding(.leading, 120)

      if let biography = viewState.item.biography {
        if !biography.isEmpty {
          VStack(alignment: .leading, spacing: 8) {
            Text("Biography")
              .fontWeight(.bold)

            Text(biography)
              .font(.system(size: 16))
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
              .multilineTextAlignment(.leading)
              .lineLimit(store.isShowingReadMore ? .none : 4)

            Button(action: { store.isShowingReadMore.toggle() }) {
              Text(store.isShowingReadMore ? "Less" : "Read More")
                .foregroundStyle(DesignSystemColor.label(.greenSlate).color)
            }
          }
          .padding(.vertical, 4)
          .frame(maxWidth: .infinity, alignment: .leading)

          Divider()
        }
      }

      if let birth = viewState.item.birth {
        if !birth.isEmpty {
          Text("Place of birth")
            .fontWeight(.bold)

          Text(birth)
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)

          Divider()
        }
      }
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
