import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.OtherPosterItemListComponent

extension MovieDetailPage {
  struct OtherPosterItemListComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void
//    let tapAction: () -> Void

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
//            Button(action: {  }) {
            RemoteImage(
              url: "https://image.tmdb.org/t/p/w500/\(item.image ?? "")",
              placeholder: {
                Rectangle()
                  .fill(DesignSystemColor.palette(.gray(.lv250)).color)
              })
              .scaledToFill()
              .frame(width: 100, height: 160)
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .shadow(radius: 5)
              .padding(.top, 8)
//            }
          }
          .onTapGesture {
            tapAction(viewState.item)
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

// MARK: - MovieDetailPage.OtherPosterItemListComponent.ViewState

extension MovieDetailPage.OtherPosterItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.Response
  }
}
