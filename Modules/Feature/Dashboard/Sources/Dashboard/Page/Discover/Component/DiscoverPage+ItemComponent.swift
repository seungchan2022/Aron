import DesignSystem
import Domain
import SwiftUI

// MARK: - DiscoverPage.ItemComponent

extension DiscoverPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Discover.Movie.Item) -> Void
  }
}

extension DiscoverPage.ItemComponent {
  private var posterImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.poster ?? "")"
  }
}

// MARK: - DiscoverPage.ItemComponent + View

extension DiscoverPage.ItemComponent: View {
  var body: some View {
    VStack(spacing: 16) {
      RemoteImage(
        url: posterImageURL,
        placeholder: {
          Rectangle()
            .fill(.gray)
        })
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
          tapAction(viewState.item)
        }

      Text(viewState.item.title)
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
    }
    .background(.ultraThickMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}

// MARK: - DiscoverPage.ItemComponent.ViewState

extension DiscoverPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Discover.Movie.Item
  }
}
