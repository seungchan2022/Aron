import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - NowPlayingPage.SearchResultKeywordComponent

extension NowPlayingPage {
  struct SearchResultKeywordComponent {
    let viewState: ViewState
    let tapAction: () -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension NowPlayingPage.SearchResultKeywordComponent { }

// MARK: - NowPlayingPage.SearchResultKeywordComponent + View

extension NowPlayingPage.SearchResultKeywordComponent: View {
  var body: some View {
    Button(action: { tapAction() }) {
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

// MARK: - NowPlayingPage.SearchResultKeywordComponent.ViewState

extension NowPlayingPage.SearchResultKeywordComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Search.Keyword.Item
  }
}
