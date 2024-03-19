import DesignSystem
import SwiftUI

// MARK: - MovieDetailPage.OtherPosterItemListComponent

extension MovieDetailPage {
  struct OtherPosterItemListComponent {
    let viewState: ViewState
    let tapAction: () -> Void

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
          ForEach(viewState.imageBucket.posterItemList.prefix(8)) { _ in
            // 여기서는 모든 아이템이 똑같은 로직이 수행됌
            Button(action: { }) {
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
    let imageBucket: PosterItemList
  }

  struct PosterItemList: Equatable {
    let posterItemList: [PosterItem]
  }

  struct PosterItem: Equatable, Identifiable {
    let id: Int
    let image: Image?
  }
}
