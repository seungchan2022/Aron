import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieListPage.NowPlayingItemComponent

extension MovieListPage {
  struct NowPlayingItemComponent {
    let viewState: ViewState

    let tapSeeAllAction: () -> Void
    let tapItemAction: (MovieEntity.Movie.NowPlaying.Item) -> Void

    @Environment(\.colorScheme) var colorScheme

  }
}

extension MovieListPage.NowPlayingItemComponent { }

// MARK: - MovieListPage.NowPlayingItemComponent + View

extension MovieListPage.NowPlayingItemComponent: View {
  var body: some View {
    VStack(spacing: .zero) {
      Divider()
        .padding(.leading, 16)

      VStack(spacing: .zero) {
        Button(action: {
          // See All
          tapSeeAllAction()
        }) {
          HStack {
            Text("Now Playing")
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
            ForEach(viewState.item.itemList) { item in
              Button(action: {
                tapItemAction(item)
              }) {
                RemoteImage(
                  url: "https://image.tmdb.org/t/p/w500/\(item.poster ?? "")",
                  placeholder: {
                    Rectangle()
                      .fill(DesignSystemColor.palette(.gray(.lv250)).color)
                  })
                  .scaledToFill()
                  .frame(width: 80, height: 120)
                  .clipShape(RoundedRectangle(cornerRadius: 5))
              }
            }
          }
        }
        .padding(.horizontal, 12)
      }
    }
  }
}

// MARK: - MovieListPage.NowPlayingItemComponent.ViewState

extension MovieListPage.NowPlayingItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Movie.NowPlaying.Response
  }
}
