import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - NowPlayingPage.SearchResultPersonComponent

extension NowPlayingPage {
  struct SearchResultPersonComponent {
    let viewState: ViewState
    let tapAction: () -> Void

    @Bindable var store: StoreOf<NowPlayingReducer>
    @Environment(\.colorScheme) var colorScheme

  }
}

extension NowPlayingPage.SearchResultPersonComponent { }

// MARK: - NowPlayingPage.SearchResultPersonComponent + View

extension NowPlayingPage.SearchResultPersonComponent: View {
  var body: some View {
    LazyVStack(alignment: .leading, spacing: 16) {
      if viewState.personItemList.isEmpty {
        Text("No Results")
          .font(.system(size: 18))
          .foregroundStyle(colorScheme == .dark ? DesignSystemColor.system(.white).color : DesignSystemColor.system(.black).color)
          .padding(.top, -8)

        Divider()

        Divider()
          .padding(.top, 24)
      }

      ForEach(viewState.personItemList) { item in

        Button(action: {
          tapAction()
          print("profile tap")
        }) {
          HStack(spacing: 12) {
            Rectangle()
              .fill(.gray)
              .frame(width: 80, height: 100)
              .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading) {
              Spacer()

              Text(item.name)
                .font(.system(size: 18))
                .foregroundStyle(DesignSystemColor.label(.ocher).color)

              Spacer()

              if let workList = item.workList {
                Text(workList.joined(separator: ", "))
                  .font(.system(size: 16))
                  .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                  .multilineTextAlignment(.leading)
                  .lineLimit(3)
              }

              Spacer()
            }

            Spacer()

            Image(systemName: "chevron.right")
              .resizable()
              .frame(width: 8, height: 12)
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
              .padding(.trailing, 16)
          }
        }

        if viewState.personItemList.last != item {
          Divider()
            .padding(.leading, 80)
            .padding(.top, 12)
        }
      }
    }
    .padding(.vertical, 12)
    .padding(.leading, 16)
  }
}

extension NowPlayingPage.SearchResultPersonComponent {
  struct ViewState: Equatable {
    let personItemList: [PersonItem]
  }

  struct PersonItem: Equatable, Identifiable {
    let id: Int
    let name: String
    let workList: [String]?
  }
}
