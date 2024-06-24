import DesignSystem
import Domain
import SwiftUI

// MARK: - SimilarPage.ItemComponent

extension SimilarPage {
  struct ItemComponent {
    let viewState: ViewState

    let tapAction: (MovieEntity.MovieDetail.SimilarMovie.Response.Item) -> Void

    @Environment(\.colorScheme) var colorScheme

  }
}

extension SimilarPage.ItemComponent {
  private var remoteImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.poster ?? "")"
  }

  private var releaseDate: String {
    viewState.item.releaseDate.toDate?.toString ?? ""
  }

  private var voteAverage: String {
    "\(Int((viewState.item.voteAverage ?? .zero) * 10))%"
  }

  private var voteAveragePercent: Double {
    Double(Int(viewState.item.voteAverage ?? .zero) * 10) / 100
  }

  private var voteAverageColor: Color {
    let voteAverage = Int((viewState.item.voteAverage ?? .zero) * 10)

    switch voteAverage {
    case 0..<25:
      return DesignSystemColor.tint(.red).color
    case 25..<50:
      return DesignSystemColor.tint(.orange).color
    case 50..<75:
      return DesignSystemColor.tint(.yellow).color
    default:
      return DesignSystemColor.tint(.green).color
    }
  }

}

// MARK: - SimilarPage.ItemComponent + View

extension SimilarPage.ItemComponent: View {
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
              Circle()
                .trim(from: .zero, to: voteAveragePercent)
                .stroke(
                  voteAverageColor,
                  style: .init(
                    lineWidth: 2,
                    lineCap: .butt,
                    lineJoin: .miter,
                    miterLimit: .zero,
                    dash: [1, 1.5],
                    dashPhase: .zero))
                .shadow(color: voteAverageColor, radius: 5)
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(-90))
                .overlay {
                  Text(voteAverage)
                    .font(.system(size: 14))
                    .foregroundStyle(
                      colorScheme == .dark
                        ? DesignSystemColor.system(.white).color
                        : DesignSystemColor.system(.black).color)
                }

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

// MARK: - SimilarPage.ItemComponent.ViewState

extension SimilarPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.SimilarMovie.Response.Item
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
