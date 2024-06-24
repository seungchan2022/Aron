import DesignSystem
import Domain
import SwiftUI

// MARK: - ProfilePage.ImageComponent

extension ProfilePage {
  struct ImageComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) var colorScheme

  }
}

extension ProfilePage.ImageComponent { }

// MARK: - ProfilePage.ImageComponent + View

extension ProfilePage.ImageComponent: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("Images")
        .padding(.leading, 16)

      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(viewState.item.profileItemList, id: \.profileImageURL) { item in
            RemoteImage(
              url: "https://image.tmdb.org/t/p/w500/\(item.profileImageURL ?? "")",
              placeholder: {
                Image(systemName: "person.fill")
                  .resizable()
                  .foregroundStyle(DesignSystemColor.palette(.gray(.lv250)).color)
              })
              .clipShape(RoundedRectangle(cornerRadius: 5))
              .frame(width: 80, height: 100)
          }
          .padding(.leading, 16)

          .background(
            colorScheme == .dark
              ? DesignSystemColor.background(.black).color
              : DesignSystemColor.system(.white).color)
        }
      }
      .scrollIndicators(.hidden)
    }
    .padding(.top, 16)
  }
}

// MARK: - ProfilePage.ImageComponent.ViewState

extension ProfilePage.ImageComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Person.Image.Response
  }
}
