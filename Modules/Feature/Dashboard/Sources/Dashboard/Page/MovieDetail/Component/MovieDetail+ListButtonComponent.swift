import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.ListButtonComponent

extension MovieDetailPage {
  struct ListButtonComponent {
    let viewState: ViewState
    let wishAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void
    let seenAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void
  }
}

extension MovieDetailPage.ListButtonComponent {
  private var wishButtonImage: Image {
    Image(systemName: viewState.isWish ? "heart.fill" : "heart")
  }

  private var wishButtonText: String {
    viewState.isWish ? "In wishlist" : "Wishlist"
  }

  private var wishButtonColor: Color {
    viewState.isWish
      ? DesignSystemColor.system(.white).color
      : DesignSystemColor.tint(.red).color
  }

  private var seenButtonImage: Image {
    Image(systemName: viewState.isSeen ? "eye.fill" : "heart")
  }

  private var seenButtonText: String {
    viewState.isSeen ? "Seen" : "Seenlist"
  }

  private var seenButtonColor: Color {
    viewState.isSeen
      ? DesignSystemColor.system(.white).color
      : DesignSystemColor.tint(.green).color
  }

}

// MARK: - MovieDetailPage.ListButtonComponent + View

extension MovieDetailPage.ListButtonComponent: View {
  var body: some View {
    HStack(spacing: 12) {
      Button(action: {
        wishAction(viewState.item)
      }) {
        HStack {
          wishButtonImage
            .resizable()
            .frame(width: 16, height: 16)

          Text(wishButtonText)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(wishButtonColor)
        .background(
          RoundedRectangle(cornerRadius: 5)
            .fill(viewState.isWish ? DesignSystemColor.tint(.red).color : Color.clear))
        .overlay {
          RoundedRectangle(cornerRadius: 5).stroke(DesignSystemColor.tint(.red).color, lineWidth: 1)
        }
      }

      Button(action: {
        seenAction(viewState.item)
      }) {
        HStack {
          seenButtonImage
            .resizable()
            .frame(width: 20, height: 16)

          Text(seenButtonText)
        }
      }
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .foregroundStyle(seenButtonColor)
      .background(
        RoundedRectangle(cornerRadius: 5)
          .fill(viewState.isSeen ? DesignSystemColor.tint(.green).color : Color.clear))
      .overlay {
        RoundedRectangle(cornerRadius: 5).stroke(DesignSystemColor.tint(.green).color, lineWidth: 1)
      }
      Spacer()
    }
    .padding(.vertical, 12)
    .padding(.leading, 12)
  }
}

// MARK: - MovieDetailPage.ListButtonComponent.ViewState

extension MovieDetailPage.ListButtonComponent {
  struct ViewState: Equatable {
    let isWish: Bool
    let isSeen: Bool
    let item: MovieEntity.MovieDetail.MovieCard.Response
  }
}
