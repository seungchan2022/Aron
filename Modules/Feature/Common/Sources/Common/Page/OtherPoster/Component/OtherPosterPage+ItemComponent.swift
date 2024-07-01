import DesignSystem
import Domain
import SwiftUI

// MARK: - OtherPosterPage.ItemComponent

extension OtherPosterPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapBackAction: () -> Void
  }
}

extension OtherPosterPage.ItemComponent { }

// MARK: - OtherPosterPage.ItemComponent + View

extension OtherPosterPage.ItemComponent: View {
  var body: some View {
    VStack {
      GeometryReader { geometry in
        ScrollView(.horizontal) {
          LazyHStack(spacing: .zero) {
            ForEach(viewState.item.otherPosterItemList ?? [], id: \.image) { item in
              GeometryReader { proxy in
                RemoteImage(
                  url: "https://image.tmdb.org/t/p/w500/\(item.image ?? "")",
                  placeholder: {
                    Rectangle()
                      .fill(DesignSystemColor.palette(.gray(.lv250)).color)
                  })
                  .aspectRatio(contentMode: .fill)
                  .frame(width: proxy.size.width, height: proxy.size.height)
                  .clipShape(.rect(cornerRadius: 15))
              } // proxy
              .frame(width: geometry.size.width - 60)
              .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                content.scaleEffect(phase.isIdentity ? 1 : 0.9)
              }
            }
          }
          .padding(.horizontal, 30)
          .scrollTargetLayout()
          .frame(height: geometry.size.height, alignment: .top)
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
      } // geometry
      .frame(height: 500)

      Button(action: { tapBackAction() }) {
        Image(systemName: "x.circle")
          .resizable()
          .frame(width: 50, height: 50)
          .fontWeight(.ultraLight)
          .tint(.red)
      }
      .padding(.top, 32)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.ultraThinMaterial)
  }
}

// MARK: - OtherPosterPage.ItemComponent.ViewState

extension OtherPosterPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.ImageBucket
  }
}
