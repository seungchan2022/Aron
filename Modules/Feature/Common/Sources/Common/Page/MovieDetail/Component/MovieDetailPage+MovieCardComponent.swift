import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.MovieCardComponent

extension MovieDetailPage {
  struct MovieCardComponent {
    let viewState: ViewState
    let tapGenreAction: (MovieEntity.MovieDetail.MovieCard.GenreItem) -> Void
    @Environment(\.colorScheme) var colorScheme

  }
}

extension MovieDetailPage.MovieCardComponent {

  // MARK: Public

  public var backImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.backdrop ?? "")"
  }

  // MARK: Private

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

// MARK: - MovieDetailPage.MovieCardComponent + View

extension MovieDetailPage.MovieCardComponent: View {
  var body: some View {
    VStack {
      HStack {
        RemoteImage(
          url: remoteImageURL,
          placeholder: {
            Rectangle()
              .fill(DesignSystemColor.palette(.gray(.lv250)).color)
          })
          .scaledToFill()
          .frame(width: 100, height: 160)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .padding(.top, 12)

        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Text(releaseDate)
              .font(.system(size: 16))

            Text(" • \(viewState.item.runtime) minutes")
              .lineLimit(1)
              .font(.system(size: 16))

            Text(" • \(viewState.item.status)")
              .lineLimit(1)
              .font(.system(size: 16))
          }

          Text(viewState.item.productionCountryList.first?.name ?? "")
            .font(.system(size: 16))

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
                  .font(.system(size: 12))
              }

            Text("\(viewState.item.voteCount) ratings")
              .font(.system(size: 18))
          }
          .padding(.top, 8)
        }
        .foregroundStyle(DesignSystemColor.system(.white).color)
      }
      .padding(.leading, 8)

      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(viewState.item.genreItemList) { item in
            Button(action: { tapGenreAction(item) }) {
              ItemComponent(genreItem: item)
            }
            .tint(
              colorScheme == .dark
                ? DesignSystemColor.system(.black).color
                : DesignSystemColor.system(.white).color)
              .buttonStyle(.borderedProminent)
              .buttonBorderShape(.capsule)
              .controlSize(.small)
          }
        }
        .padding(.leading, 12)
        .padding(.vertical, 12)
        .padding(.top, 8)
      }
      .scrollIndicators(.hidden)
    }
    .padding(.vertical, 16)
    .frame(maxWidth: .infinity)
    .background {
      RemoteImage(
        url: backImageURL,
        placeholder: {
          Rectangle()
            .fill(.gray)
        })
      Rectangle()
        .background(.ultraThinMaterial)
    }
  }
}

// MARK: - MovieDetailPage.MovieCardComponent.ViewState

extension MovieDetailPage.MovieCardComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.Response
  }
}

// MARK: - MovieDetailPage.MovieCardComponent.ItemComponent

extension MovieDetailPage.MovieCardComponent {
  fileprivate struct ItemComponent {
    let genreItem: MovieEntity.MovieDetail.MovieCard.GenreItem
    @Environment(\.colorScheme) var colorScheme

  }
}

// MARK: - MovieDetailPage.MovieCardComponent.ItemComponent + View

extension MovieDetailPage.MovieCardComponent.ItemComponent: View {
  var body: some View {
    HStack {
      Text(genreItem.name)
        .font(.system(size: 16))

      Image(systemName: "chevron.right")
        .resizable()
        .frame(width: 8, height: 12)
    }
    .foregroundStyle(
      colorScheme == .dark
        ? DesignSystemColor.system(.white).color
        : DesignSystemColor.system(.black).color)
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
    displayFormatter.dateFormat = "yyyy"
    return displayFormatter.string(from: self)
  }
}
