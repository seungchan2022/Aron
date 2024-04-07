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
      ScrollView(.horizontal) {
        LazyHStack(spacing: 0) {
          ForEach(viewState.item.otherPosterItemList ?? [], id: \.image) { item in
            RemoteImage(
              url: "https://image.tmdb.org/t/p/w500/\(item.image ?? "")",
              placeholder: {
                Rectangle()
                  .fill(DesignSystemColor.palette(.gray(.lv250)).color)
              })
              .frame(height: 300)
              .clipShape(RoundedRectangle(cornerRadius: 25.0))
              .padding(.horizontal, 4)
              .containerRelativeFrame(.horizontal)
          }
          .scrollTransition(.animated, axis: .horizontal) { content, phase in
            content
              .opacity(phase.isIdentity ? 1.0 : 0.8)
              .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
          }
        }
      }
      .scrollIndicators(.hidden)
      .scrollTargetBehavior(.paging)

      Spacer()

      Button(action: { tapBackAction() }) {
        Image(systemName: "x.circle")
          .resizable()
          .frame(width: 50, height: 50)
          .fontWeight(.ultraLight)
          .tint(.red)
      }
    }
  }
}

// MARK: - OtherPosterPage.ItemComponent.ViewState

extension OtherPosterPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.ImageBucket
  }
}
