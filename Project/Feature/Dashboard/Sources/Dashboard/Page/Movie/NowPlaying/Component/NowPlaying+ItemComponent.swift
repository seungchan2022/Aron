import DesignSystem
import Domain
import SwiftUI

// MARK: - NowPlayingPage.ItemComponent

extension NowPlayingPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: () -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension NowPlayingPage.ItemComponent {
  private var releaseDate: String {
    viewState.item.releaseDate.toDate?.toString ?? ""
  }

  private var voteAverage: String {
    "\(Int((viewState.item.voteAverage) * 10))%"
  }
}

// MARK: - NowPlayingPage.ItemComponent + View

extension NowPlayingPage.ItemComponent: View {
  var body: some View {
    Button(action: { tapAction() }) {
      VStack {
        HStack(spacing: 8) {
          Rectangle()
            .fill(.gray)
            .frame(width: 100, height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 10))

          VStack(alignment: .leading, spacing: 16) {
            Text(viewState.item.title)
              .font(.system(size: 18))
              .foregroundStyle(DesignSystemColor.label(.ocher).color)

            HStack {
              Text(voteAverage)
                .font(.system(size: 14))
                .foregroundStyle(
                  colorScheme == .dark
                    ? DesignSystemColor.system(.white).color
                    : DesignSystemColor.system(.black).color)

              Text(releaseDate)
                .font(.system(size: 16))
                .foregroundStyle(
                  colorScheme == .dark
                    ? DesignSystemColor.system(.white).color
                    : DesignSystemColor.system(.black).color)
            }

            if let overview = viewState.item.overview {
              Text(overview)
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        Divider()
          .padding(.leading, 120)
      }
    }
  }
}

// MARK: - NowPlayingPage.ItemComponent.ViewState

extension NowPlayingPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Movie.NowPlaying.Response.Item
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
