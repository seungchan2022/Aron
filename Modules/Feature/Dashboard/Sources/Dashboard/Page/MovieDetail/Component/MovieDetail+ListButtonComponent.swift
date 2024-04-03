import DesignSystem
import SwiftUI

// MARK: - MovieDetailPage.ListButtonComponent

extension MovieDetailPage {
  struct ListButtonComponent {
    let viewState: ViewState

    @Binding var isWishListButtonTapped: Bool
    @Binding var isSeenListButtonTapped: Bool
    @Binding var isShowingConfirmation: Bool
  }
}

extension MovieDetailPage.ListButtonComponent { }

// MARK: - MovieDetailPage.ListButtonComponent + View

extension MovieDetailPage.ListButtonComponent: View {
  var body: some View {
    HStack(spacing: 12) {
      Button(action: {
        self.isWishListButtonTapped.toggle()
        self.isSeenListButtonTapped = false
      }) {
        HStack {
          Image(systemName: "heart")
            .resizable()
            .frame(width: 16, height: 16)

          Text(isWishListButtonTapped ? "In wishlist" : "Wishlist")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(
          isWishListButtonTapped
            ? DesignSystemColor.system(.white).color
            : DesignSystemColor.tint(.red).color)
          .background(
            RoundedRectangle(cornerRadius: 5)
              .fill(isWishListButtonTapped ? DesignSystemColor.tint(.red).color : Color.clear))
          .overlay {
            RoundedRectangle(cornerRadius: 5).stroke(DesignSystemColor.tint(.red).color, lineWidth: 1)
          }
      }

      Button(action: {
        self.isWishListButtonTapped = false
        self.isSeenListButtonTapped.toggle()
      }) {
        HStack {
          Image(systemName: "eye")
            .resizable()
            .frame(width: 20, height: 16)

          Text(isSeenListButtonTapped ? "Seen" : "Seenlist")
        }
      }
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .foregroundStyle(
        isSeenListButtonTapped
          ? DesignSystemColor.system(.white).color
          : DesignSystemColor.tint(.green).color)
        .background(
          RoundedRectangle(cornerRadius: 5)
            .fill(isSeenListButtonTapped ? DesignSystemColor.tint(.green).color : Color.clear))
        .overlay {
          RoundedRectangle(cornerRadius: 5).stroke(DesignSystemColor.tint(.green).color, lineWidth: 1)
        }

      Button(action: {
        self.isShowingConfirmation = true
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
        isPresented: $isShowingConfirmation)
      {
        Button(
          role: isWishListButtonTapped ? .destructive : .none,
          action: {
            self.isWishListButtonTapped.toggle()
            self.isSeenListButtonTapped = false
          }) {
            Text(isWishListButtonTapped ? "Remove from wishlist" : "Add to wishlist")
          }
        Button(
          role: isSeenListButtonTapped ? .destructive : .none,
          action: {
            self.isSeenListButtonTapped.toggle()
            self.isWishListButtonTapped = false
          }) {
            Text(isSeenListButtonTapped ? "Remove from seenlist" : "Add to seenlist")
          }
        Button(action: { }) {
          Text("Create List")
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
  struct ViewState: Equatable { }
}
