import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - HomePage.SearchResultMovieComponent

extension HomePage {
  struct SearchResultMovieComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Search.Movie.Item) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension HomePage.SearchResultMovieComponent {
  private var remoteImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.poster ?? "")"
  }
}

// MARK: - HomePage.SearchResultMovieComponent + View

extension HomePage.SearchResultMovieComponent: View {

  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack {
        HStack(spacing: 8) {
          RemoteImage(
            url: remoteImageURL,
            placeholder: {
              Rectangle()
                .fill(.gray)
            })
            .scaledToFill()
            .frame(width: 100, height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)

          VStack(alignment: .leading, spacing: 16) {
            Text(viewState.item.title)
              .font(.system(size: 18))
              .foregroundStyle(DesignSystemColor.label(.ocher).color)
              .multilineTextAlignment(.leading)

            HStack {
              Text("\(Int(viewState.item.voteAverage ?? 0 * 10))%")
                .font(.system(size: 18))
                .foregroundStyle(
                  colorScheme == .dark
                    ? DesignSystemColor.system(.white).color
                    : DesignSystemColor.system(.black).color)

              Text(viewState.item.releaseDate.toDate?.toString ?? "")
                .font(.system(size: 16))
                .foregroundStyle(
                  colorScheme == .dark
                    ? DesignSystemColor.system(.white).color
                    : DesignSystemColor.system(.black).color)
            }

            if let overView = viewState.item.overview {
              Text(overView)
                .font(.system(size: 18))
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            }
          }

          Spacer()

          Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 8, height: 12)
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
            .padding(.trailing, 16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        Divider()
          .padding(.leading, 120)
      }
    }
  }
}

// MARK: - HomePage.SearchResultMovieComponent.ViewState

extension HomePage.SearchResultMovieComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Search.Movie.Item
  }
}

extension String {
  fileprivate var toDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: self)
  }
}

extension Date {
  fileprivate var toString: String? {
    let displayFormatter = DateFormatter()
    displayFormatter.dateFormat = "MMM d, yyyy"
    return displayFormatter.string(from: self)
  }
}
