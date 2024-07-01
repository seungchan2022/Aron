import DesignSystem
import Domain
import SwiftUI

// MARK: - ReviewPage.ItemComponent

extension ReviewPage {
  struct ItemComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) var colorScheme
  }
}

extension ReviewPage.ItemComponent { }

// MARK: - ReviewPage.ItemComponent + View

extension ReviewPage.ItemComponent: View {
  var body: some View {
    LazyVStack {
      ForEach(viewState.item.itemList, id: \.author) { item in
        VStack(alignment: .leading, spacing: 16) {
          Text("Review written by \(item.author)")
            .fontWeight(.bold)

          Text(item.content)

          Divider()
        }
      }
      .padding(16)

      .background(
        colorScheme == .dark
          ? DesignSystemColor.background(.black).color
          : DesignSystemColor.system(.white).color)
    }
    .background(
      colorScheme == .dark
        ? DesignSystemColor.background(.black).color
        : DesignSystemColor.system(.white).color)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .padding(.horizontal, 12)
  }
}

// MARK: - ReviewPage.ItemComponent.ViewState

extension ReviewPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.Review.Response
  }
}
