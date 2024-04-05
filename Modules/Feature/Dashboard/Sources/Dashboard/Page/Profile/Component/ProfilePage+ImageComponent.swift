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

extension ProfilePage.ImageComponent {
//  private var profileImageURL: String {
//    "https://image.tmdb.org/t/p/w500/\(viewState.item.profileItemList. ?? "")"
//  }
}

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
                Rectangle()
                  .fill(DesignSystemColor.palette(.gray(.lv250)).color)
              })
              .scaledToFill()
              .frame(width: 60, height: 80)
              .clipShape(RoundedRectangle(cornerRadius: 10))
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
