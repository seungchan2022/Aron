import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - TrendingPage.SearchResultKeywordComponent

extension TrendingPage {
  struct SearchResultKeywordComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Search.Keyword.Item) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension TrendingPage.SearchResultKeywordComponent { }

// MARK: - TrendingPage.SearchResultKeywordComponent + View

extension TrendingPage.SearchResultKeywordComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      HStack {
        Text(viewState.item.name)
          .font(.system(size: 16))
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)

        Spacer()

        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 8, height: 12)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          .padding(.trailing, 16)
      }
    }
  }
}

// MARK: - TrendingPage.SearchResultKeywordComponent.ViewState

extension TrendingPage.SearchResultKeywordComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Search.Keyword.Item
  }
}
