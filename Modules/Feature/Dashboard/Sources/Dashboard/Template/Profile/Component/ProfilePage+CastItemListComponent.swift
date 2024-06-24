import DesignSystem
import Domain
import SwiftUI

// MARK: - ProfilePage.CastItemListComponent

extension ProfilePage {
  struct CastItemListComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Person.MovieCredit.CastItem) -> Void

    @Environment(\.colorScheme) var colorScheme

  }
}

extension ProfilePage.CastItemListComponent {
  private var filteredItemList: [MovieEntity.Person.MovieCredit.CastItem] {
    viewState.item.castItemList.reduce(into: [MovieEntity.Person.MovieCredit.CastItem]()) { curr, next in
      guard !curr.contains(where: { $0.id == next.id }) else { return }
      curr = curr + [next]
    }
  }
}

// MARK: - ProfilePage.CastItemListComponent + View

extension ProfilePage.CastItemListComponent: View {
  var body: some View {
    if !viewState.item.castItemList.isEmpty {
      VStack(alignment: .leading, spacing: .zero) {
        Text("Cast")
          .font(.title)
          .fontWeight(.bold)
          .padding(.leading, 32)

        LazyVStack(alignment: .leading) {
          ForEach(filteredItemList) { item in
            Button(action: { tapAction(item) }) {
              ItemComponent(castItem: item)
            }
          }
        }
        .background(
          colorScheme == .dark
            ? DesignSystemColor.background(.black).color
            : DesignSystemColor.system(.white).color)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .padding(.horizontal, 12)
      }
    }
  }
}

// MARK: - ProfilePage.CastItemListComponent.ViewState

extension ProfilePage.CastItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Person.MovieCredit.Response
  }
}

// MARK: - ProfilePage.CastItemListComponent.ItemComponent

extension ProfilePage.CastItemListComponent {
  fileprivate struct ItemComponent {
    let castItem: MovieEntity.Person.MovieCredit.CastItem

    @Environment(\.colorScheme) var colorScheme
  }
}

extension ProfilePage.CastItemListComponent.ItemComponent {
  private var remoteImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(castItem.poster ?? "")"
  }
}

// MARK: - ProfilePage.CastItemListComponent.ItemComponent + View

extension ProfilePage.CastItemListComponent.ItemComponent: View {
  var body: some View {
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
          Text(castItem.title)
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)
              .multilineTextAlignment(.leading)

          if let character = castItem.character {
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
