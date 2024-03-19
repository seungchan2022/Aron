import DesignSystem
import SwiftUI

// MARK: - MovieDetailPage.KeywordItemListComponent

extension MovieDetailPage {
  struct KeywordItemListComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.KeywordItemListComponent { }

// MARK: - MovieDetailPage.KeywordItemListComponent + View

extension MovieDetailPage.KeywordItemListComponent: View {
  var body: some View {
    if !(viewState.keywordBucket.keywordItem?.isEmpty ?? true) {
      VStack(alignment: .leading) {
        Text("Keywords")
          .padding(.leading, 12)

        ScrollView(.horizontal) {
          LazyHStack {
            ForEach(viewState.keywordBucket.keywordItem ?? []) { item in
              Button(action: { }) {
                HStack {
                  Text(item.name)
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

extension MovieDetailPage.KeywordItemListComponent {
  struct ViewState: Equatable {
    let keywordBucket: KeywordItemList
  }

  struct KeywordItemList: Equatable {
    let keywordItem: [KeywordItem]?
  }

  struct KeywordItem: Equatable, Identifiable {
    let id: Int
    let name: String
  }
}
