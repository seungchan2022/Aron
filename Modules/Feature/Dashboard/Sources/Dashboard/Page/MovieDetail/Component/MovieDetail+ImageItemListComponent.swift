import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.ImageItemListComponent

extension MovieDetailPage {
  struct ImageItemListComponent {
    let viewState: ViewState
    
    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.ImageItemListComponent { }

// MARK: - MovieDetailPage.ImageItemListComponent + View

extension MovieDetailPage.ImageItemListComponent: View {
  var body: some View {
    if !(viewState.item.imageBucket.backdropImageList?.isEmpty ?? true) {
      Divider()
        .padding(.leading, 16)
      
      VStack(alignment: .leading) {
        Text("Images")
          .font(.system(size: 16))
          .foregroundStyle(
            colorScheme == .dark
            ? DesignSystemColor.system(.white).color
            : DesignSystemColor.system(.black).color)
          .padding(.leading, 12)
          .padding(.top, 8)
        
        ScrollView(.horizontal) {
          LazyHStack(spacing: .zero) {
            ForEach(viewState.item.imageBucket.backdropImageList?.prefix(8) ?? [], id: \.image) { item in
              RemoteImage(
                url: "https://image.tmdb.org/t/p/w500/\(item.image ?? "")",
                placeholder: {
                  Rectangle()
                    .fill(DesignSystemColor.palette(.gray(.lv250)).color)
                })
              .frame(width: 300, height: 140)
            }
          }
        }
        .padding(.top, 12)
        .scrollIndicators(.hidden)
      }
      .padding(.bottom, 12)
    }
  }
}

// MARK: - MovieDetailPage.ImageItemListComponent.ViewState

extension MovieDetailPage.ImageItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.Response
  }
}
