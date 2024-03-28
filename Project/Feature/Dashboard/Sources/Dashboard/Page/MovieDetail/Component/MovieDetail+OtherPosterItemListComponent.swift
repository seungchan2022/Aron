import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.OtherPosterItemListComponent

extension MovieDetailPage {
  struct OtherPosterItemListComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.MovieDetail.MovieCard.PosterItem) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.OtherPosterItemListComponent { }

// MARK: - MovieDetailPage.OtherPosterItemListComponent + View

extension MovieDetailPage.OtherPosterItemListComponent: View {
  var body: some View {
    Divider()
      .padding(.leading, 16)

    VStack(alignment: .leading) {
      Text("Other posters")
        .font(.system(size: 16))
        .foregroundStyle(
          colorScheme == .dark
            ? DesignSystemColor.system(.white).color
            : DesignSystemColor.system(.black).color)

        .padding(.leading, 12)
        .padding(.top, 8)

      ScrollView(.horizontal) {
        LazyHStack(spacing: 32) {
          ForEach(viewState.item.imageBucket.otherPosterItemList?.prefix(8) ?? [], id: \.image) { item in
            Button(action: { tapAction(item) }) {
              Rectangle()
                .fill(DesignSystemColor.palette(.gray(.lv250)).color)
                .frame(width: 80, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
          }
        }
        .padding(.leading, 20)
      }
      .padding(.top, 12)
      .scrollIndicators(.hidden)
    }
    .padding(.bottom, 12)
  }
}

extension MovieDetailPage.OtherPosterItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.Response
  }
}
