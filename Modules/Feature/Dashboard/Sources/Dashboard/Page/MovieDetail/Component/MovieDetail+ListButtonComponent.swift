import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.ListButtonComponent

extension MovieDetailPage {
  struct ListButtonComponent {
    var viewState: ViewState
    let tapWishAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void
    let tapSeenAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void

    @Bindable var store: StoreOf<MovieDetailReducer>
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
    Image(systemName: viewState.isSeen ? "eye.fill" : "eye")
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
        tapWishAction(viewState.item)
        store.fetchIsSeen.value = false
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
        tapSeenAction(viewState.item)
        store.fetchIsWish.value = false
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

      Button(action: {
        store.isShowingConfirmation = true
      }) {
        HStack {
          Image(systemName: "pin")
            .resizable()
            .frame(width: 12, height: 16)

          Text("List")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(DesignSystemColor.label(.ocher).color)
        .overlay {
          RoundedRectangle(cornerRadius: 5).stroke(DesignSystemColor.label(.ocher).color, lineWidth: 1)
        }
      }
      .confirmationDialog(
        "",
        isPresented: $store.isShowingConfirmation)
      {
        Button(
          role: viewState.isWish ? .destructive : .none,
          action: {
            tapWishAction(viewState.item)
            store.fetchIsSeen.value = false
          }) {
            Text(viewState.isWish ? "Remove from wishlist" : "Add to wishlist")
          }
        Button(
          role: viewState.isSeen ? .destructive : .none,
          action: {
            tapSeenAction(viewState.item)
            store.fetchIsWish.value = false
          }) {
            Text(viewState.isSeen ? "Remove from seenlist" : "Add to seenlist")
          }
      } message: {
        Text("Add or Remove movie name from your lists")
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
