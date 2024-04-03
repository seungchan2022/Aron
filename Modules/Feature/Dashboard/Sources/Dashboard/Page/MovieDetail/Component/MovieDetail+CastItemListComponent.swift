import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.CastItemListComponent

extension MovieDetailPage {
  struct CastItemListComponent {
    let viewState: ViewState
    let tapSeaAllAction: (MovieEntity.MovieDetail.Credit.Response) -> Void
    let tapCastAction: () -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.CastItemListComponent { }

// MARK: - MovieDetailPage.CastItemListComponent + View

extension MovieDetailPage.CastItemListComponent: View {
  var body: some View {
    Divider()
      .padding(.leading, 16)

    VStack(spacing: .zero) {
      Button(action: {
        tapSeaAllAction(viewState.item)
      }) {
        HStack {
          Text("Cast")
            .font(.system(size: 16))
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)

          Text("See all")
            .font(.system(size: 16))
            .foregroundStyle(DesignSystemColor.label(.greenSlate).color)

          Spacer()

          Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 8, height: 12)
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
        }
        .padding(.top, 4)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
      }

      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(viewState.item.castItemList) { item in
            Button(action: {
              tapCastAction()
            }) {
              ItemComponent(castItem: item)
            }
          }
        }
        .padding(.leading, 12)
      }
      .padding(.top, 12)
      .scrollIndicators(.hidden)
    }
    .padding(.bottom, 12)
  }
}

// MARK: - MovieDetailPage.CastItemListComponent.ViewState

extension MovieDetailPage.CastItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.Credit.Response
  }
}

// MARK: - MovieDetailPage.CastItemListComponent.ItemComponent

extension MovieDetailPage.CastItemListComponent {
  fileprivate struct ItemComponent {
    let castItem: MovieEntity.MovieDetail.Credit.CastItem

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.CastItemListComponent.ItemComponent {
  private var profileImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(castItem.profile ?? "")"
  }
}

// MARK: - MovieDetailPage.CastItemListComponent.ItemComponent + View

extension MovieDetailPage.CastItemListComponent.ItemComponent: View {
  var body: some View {
    VStack {
      RemoteImage(
        url: profileImageURL,
        placeholder: {
          Rectangle()
            .fill(DesignSystemColor.palette(.gray(.lv250)).color)
        })
        .scaledToFill()
        .frame(width: 80, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 10))
      Text(castItem.name)
        .font(.system(size: 16))
        .foregroundStyle(
          colorScheme == .dark
            ? DesignSystemColor.system(.white).color
            : DesignSystemColor.system(.black).color)
          .lineLimit(1)

      Text(castItem.character)
        .font(.system(size: 16))
        .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
        .lineLimit(1)
    }
    .frame(width: 120)
  }
}
