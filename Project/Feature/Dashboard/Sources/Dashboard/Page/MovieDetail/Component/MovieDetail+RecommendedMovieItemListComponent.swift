import DesignSystem
import SwiftUI

// MARK: - MovieDetailPage.RecommendedMovieItemListComponent

extension MovieDetailPage {
  struct RecommendedMovieItemListComponent {
    let viewState: ViewState
    let tapAction: () -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.RecommendedMovieItemListComponent { }

// MARK: - MovieDetailPage.RecommendedMovieItemListComponent + View

extension MovieDetailPage.RecommendedMovieItemListComponent: View {
  var body: some View {
    if !(viewState.recommendedMovieList?.isEmpty ?? true) {
      Divider()
        .padding(.leading, 16)

      VStack(spacing: .zero) {
        Button(action: { tapAction() }) {
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
            ForEach(viewState.recommendedMovieList ?? []) { item in
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
        .scrollIndicators(.hidden)
      }
      .padding(.bottom, 12)
    }
  }
}

extension MovieDetailPage.RecommendedMovieItemListComponent {
  struct ViewState: Equatable {
    let recommendedMovieList: [RecommendedMovieItem]?
  }

  struct RecommendedMovieItem: Equatable, Identifiable {
    let id: Int
    let poster: Image?
    let title: String
    let voteAverage: Double
  }
}
