import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.ReviewComponent

extension MovieDetailPage {
  struct ReviewComponent {
    let viewState: ViewState
//    let tapAction: (MovieEntity.MovieDetail.Review.Response) -> Void
    let tapAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void
  }
}

extension MovieDetailPage.ReviewComponent { }

// MARK: - MovieDetailPage.ReviewComponent + View

extension MovieDetailPage.ReviewComponent: View {
  var body: some View {
    if viewState.item.totalItemListCount != .zero {
      Divider()
        .padding(.leading, 48)

      Button(action: { tapAction(viewState.movieID) }) {
        HStack {
          Text("\(viewState.item.totalItemListCount) reviews")
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
    }
  }
}

// MARK: - MovieDetailPage.ReviewComponent.ViewState

extension MovieDetailPage.ReviewComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.Review.Response
    let movieID: MovieEntity.MovieDetail.MovieCard.Response
  }
}
