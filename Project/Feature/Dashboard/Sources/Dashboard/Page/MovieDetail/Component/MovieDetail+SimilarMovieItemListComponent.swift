import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.SimilarMovieItemListComponent

extension MovieDetailPage {
  struct SimilarMovieItemListComponent {
    let viewState: ViewState
    let tapAction: () -> Void

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
        Button(action: { tapAction() }) {
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
              Button(action: { }) {
                VStack {
                  Rectangle()
                    .fill(DesignSystemColor.palette(.gray(.lv250)).color)
                    .frame(width: 80, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                  Text(item.title)
                    .foregroundStyle(
                      colorScheme == .dark
                        ? DesignSystemColor.system(.white).color
                        : DesignSystemColor.system(.black).color)

                  Text("\(Int(item.voteAverage * 10)) %")
                    .foregroundStyle(
                      colorScheme == .dark
                        ? DesignSystemColor.system(.white).color
                        : DesignSystemColor.system(.black).color)
                }
              }
              .frame(width: 140)
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

  }
}
