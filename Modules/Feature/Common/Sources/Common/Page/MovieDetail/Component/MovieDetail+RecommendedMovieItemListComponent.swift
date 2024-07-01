import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.RecommendedMovieItemListComponent

extension MovieDetailPage {
  struct RecommendedMovieItemListComponent {
    let viewState: ViewState
    let tapSeeAllAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void
    let tapRecommendedMovieAction: (MovieEntity.MovieDetail.RecommendedMovie.Response.Item) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.RecommendedMovieItemListComponent { }

// MARK: - MovieDetailPage.RecommendedMovieItemListComponent + View

extension MovieDetailPage.RecommendedMovieItemListComponent: View {
  var body: some View {
    if !viewState.item.itemList.isEmpty {
      Divider()
        .padding(.leading, 16)

      VStack(spacing: .zero) {
        Button(action: { tapSeeAllAction(viewState.movieID) }) {
          HStack {
            Text("Recommended Movie")
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
              Button(action: { tapRecommendedMovieAction(item) }) {
                ItemComponent(recommendedItem: item)
              }
            }
          }
          .padding(.leading, 12)
        }
        .scrollIndicators(.hidden)
      }
      .padding(.bottom, 12)
    }
  }
}

// MARK: - MovieDetailPage.RecommendedMovieItemListComponent.ViewState

extension MovieDetailPage.RecommendedMovieItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.RecommendedMovie.Response

    let movieID: MovieEntity.MovieDetail.MovieCard.Response

  }
}

// MARK: - MovieDetailPage.RecommendedMovieItemListComponent.ItemComponent

extension MovieDetailPage.RecommendedMovieItemListComponent {
  fileprivate struct ItemComponent {
    let recommendedItem: MovieEntity.MovieDetail.RecommendedMovie.Response.Item

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.RecommendedMovieItemListComponent.ItemComponent {
  private var posterImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(recommendedItem.poster ?? "")"
  }

  private var voteAverage: String {
    "\(Int((recommendedItem.voteAverage ?? .zero) * 10))%"
  }

  private var voteAveragePercent: Double {
    Double(Int(recommendedItem.voteAverage ?? .zero) * 10) / 100
  }

  private var voteAverageColor: Color {
    let voteAverage = Int((recommendedItem.voteAverage ?? .zero) * 10)

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

// MARK: - MovieDetailPage.RecommendedMovieItemListComponent.ItemComponent + View

extension MovieDetailPage.RecommendedMovieItemListComponent.ItemComponent: View {
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

      Text(recommendedItem.title)
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
