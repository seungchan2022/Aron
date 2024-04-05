import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - FanClubPage

struct FanClubPage {
  @Bindable var store: StoreOf<FanClubReducer>

  @Environment(\.colorScheme) var colorScheme

}

// MARK: View

extension FanClubPage: View {
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .zero) {
        Text("POPULAR PEOPLE TO ADD TO YOUR FAN CLUB")
          .font(.system(size: 12, weight: .regular))
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
          .padding(.leading, 24)
          .padding(.vertical, 8)

        LazyVStack {
          ForEach(store.itemList) { item in
            Button(action: { }) {
              VStack {
                HStack(spacing: 8) {
                  Rectangle()
                    .fill(.gray)
                    .frame(width: 60, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                  VStack(alignment: .leading, spacing: 8) {
                    Text("이름")
                      .foregroundStyle(DesignSystemColor.label(.ocher).color)

                    Text("overView,overView,overView,overView,overView, overView, overView,overView, overView,")
                      .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
                      .lineLimit(2)
                      .multilineTextAlignment(.leading)
                  }

                  Spacer()

                  Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 8, height: 12)
                    .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

                Divider()
                  .padding(.leading, 120)
              }
            }
            .onAppear {
              guard let last = store.itemList.last, last.id == item.id else { return }
              guard !store.fetchItem.isLoading else { return }
              store.send(.getItem)
            }
          }
          .padding(.horizontal, 16)

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
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv200)).color)
    .navigationTitle("Fan Club")
    .navigationBarTitleDisplayMode(.large)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
