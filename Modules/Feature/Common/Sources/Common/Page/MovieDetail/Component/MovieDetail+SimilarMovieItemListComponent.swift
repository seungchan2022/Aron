import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.SimilarMovieItemListComponent

extension MovieDetailPage {
  struct SimilarMovieItemListComponent {
    let viewState: ViewState
    let tapSeeAllAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void
    let tapSimilarMovieAction: (MovieEntity.MovieDetail.SimilarMovie.Response.Item) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.SimilarMovieItemListComponent { }

// MARK: - MovieDetailPage.SimilarMovieItemListComponent + View

extension MovieDetailPage.SimilarMovieItemListComponent: View {
  var body: some View {
    if !viewState.item.itemList.isEmpty {
      Divider()
        .padding(.leading, 16)

      VStack(spacing: .zero) {
        Button(action: { tapSeeAllAction(viewState.movieID) }) {
          HStack {
            Text("Similar Movies")
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)

            Text("See all")
              .foregroundStyle(DesignSystemColor.label(.greenSlate).color)

            Spacer()

            Image(systemName: "chevron.right")
              .resizable()
              .frame(width: 8, height: 12)
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          }
          .padding(.horizontal, 16)
          .padding(.vertical, 8)
        }

        ScrollView(.horizontal) {
          LazyHStack {
            ForEach(viewState.item.itemList) { item in
              Button(action: { tapSimilarMovieAction(item) }) {
                ItemComponent(similarItem: item)
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
}

// MARK: - MovieDetailPage.SimilarMovieItemListComponent.ViewState

extension MovieDetailPage.SimilarMovieItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.SimilarMovie.Response
    let movieID: MovieEntity.MovieDetail.MovieCard.Response
  }
}

// MARK: - MovieDetailPage.SimilarMovieItemListComponent.ItemComponent

extension MovieDetailPage.SimilarMovieItemListComponent {
  fileprivate struct ItemComponent {
    let similarItem: MovieEntity.MovieDetail.SimilarMovie.Response.Item

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.SimilarMovieItemListComponent.ItemComponent {
  private var posterImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(similarItem.poster ?? "")"
  }

  private var voteAverage: String {
    "\(Int((similarItem.voteAverage ?? .zero) * 10))%"
  }

  private var voteAveragePercent: Double {
    Double(Int(similarItem.voteAverage ?? .zero) * 10) / 100
  }

  private var voteAverageColor: Color {
    let voteAverage = Int((similarItem.voteAverage ?? .zero) * 10)

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

// MARK: - MovieDetailPage.SimilarMovieItemListComponent.ItemComponent + View

extension MovieDetailPage.SimilarMovieItemListComponent.ItemComponent: View {
  var body: some View {
    VStack {
      RemoteImage(
        url: posterImageURL,
        placeholder: {
          Rectangle()
            .fill(DesignSystemColor.palette(.gray(.lv250)).color)
        })
        .scaledToFill()
        .frame(width: 100, height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
        .padding(.top, 8)

      Text(similarItem.title)
        .foregroundStyle(
          colorScheme == .dark
            ? DesignSystemColor.system(.white).color
            : DesignSystemColor.system(.black).color)
          .lineLimit(1)

      Circle()
        .trim(
          from: .zero,
          to: voteAveragePercent)
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
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)
        }
        .padding(.bottom, 8)
    }
    .frame(width: 140)
  }
}
