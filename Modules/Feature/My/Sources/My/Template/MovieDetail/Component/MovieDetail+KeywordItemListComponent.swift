import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.KeywordItemListComponent

extension MovieDetailPage {
  struct KeywordItemListComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.MovieDetail.MovieCard.KeywordItem) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.KeywordItemListComponent { }

// MARK: - MovieDetailPage.KeywordItemListComponent + View

extension MovieDetailPage.KeywordItemListComponent: View {
  var body: some View {
    if !(viewState.item.keywordBucket.keywordItem?.isEmpty ?? true) {
      VStack(alignment: .leading) {
        Text("Keywords")
          .padding(.leading, 12)

        ScrollView(.horizontal) {
          LazyHStack {
            ForEach(viewState.item.keywordBucket.keywordItem ?? []) { item in
              Button(action: { tapAction(item) }) {
                ItemComponent(keywordItem: item)
              }
              .buttonStyle(.bordered)
              .buttonBorderShape(.capsule)
              .controlSize(.small)
            }
          }
          .padding(.leading, 12)
        }

        .scrollIndicators(.hidden)
      }
      .padding(.vertical, 8)
    }
  }
}

// MARK: - MovieDetailPage.KeywordItemListComponent.ViewState

extension MovieDetailPage.KeywordItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.Response
  }
}

// MARK: - MovieDetailPage.KeywordItemListComponent.ItemComponent

extension MovieDetailPage.KeywordItemListComponent {
  fileprivate struct ItemComponent {
    let keywordItem: MovieEntity.MovieDetail.MovieCard.KeywordItem
    @Environment(\.colorScheme) var colorScheme
  }
}

// MARK: - MovieDetailPage.KeywordItemListComponent.ItemComponent + View

extension MovieDetailPage.KeywordItemListComponent.ItemComponent: View {
  var body: some View {
    HStack {
      Text(keywordItem.name)
        .font(.system(size: 16))

      Image(systemName: "chevron.right")
        .resizable()
        .frame(width: 8, height: 12)
        .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
    }
    .foregroundStyle(
      colorScheme == .dark
        ? DesignSystemColor.system(.white).color
        : DesignSystemColor.system(.black).color)
  }
}
