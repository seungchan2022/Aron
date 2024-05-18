import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - MyListPage

struct MyListPage {
  @Bindable var store: StoreOf<MyListReducer>

  @Environment(\.colorScheme) var colorScheme

}

// MARK: View

extension MyListPage: View {
  var body: some View {
    ScrollView {
      VStack {
        Picker(
          "",
          selection: $store.state.selectedLikeList)
        {
          Text(LikeList.wishList.rawValue)
            .tag(LikeList.wishList)

          Text(LikeList.seenList.rawValue)
            .tag(LikeList.seenList)
        }
        .pickerStyle(.segmented)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)

        switch store.state.selectedLikeList {
        case .wishList:
          LazyVStack(alignment: .leading, spacing: .zero) {
            Text("\(store.itemList.wishList.count) MOVIES IN WISHLIST")
              .font(.system(size: 14, weight: .regular))
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
              .padding(.horizontal, 16)
              .padding(.vertical, 8)

            if !store.itemList.wishList.isEmpty {
              ForEach(store.itemList.wishList) { item in
                ItemComponent(
                  viewState: .init(item: item),
                  tapAction: { store.send(.routeToDetail($0)) })
              }
              .padding(.horizontal, 16)
              .padding(.top, 16)
              .background(
                colorScheme == .dark
                  ? DesignSystemColor.background(.black).color
                  : DesignSystemColor.system(.white).color)
            }
          }

        case .seenList:
          LazyVStack(alignment: .leading, spacing: .zero) {
            Text("\(store.itemList.seenList.count) MOVIES IN SEENLIST")
              .font(.system(size: 14, weight: .regular))
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
              .padding(.horizontal, 16)
              .padding(.vertical, 8)

            if !store.itemList.seenList.isEmpty {
              ForEach(store.itemList.seenList) { item in
                ItemComponent(
                  viewState: .init(item: item),
                  tapAction: { store.send(.routeToDetail($0)) })
              }
              .padding(.horizontal, 16)
              .padding(.top, 16)
              .background(
                colorScheme == .dark
                  ? DesignSystemColor.background(.black).color
                  : DesignSystemColor.system(.white).color)
            }
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv100)).color)
    .navigationTitle("My Lists")
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { store.isShowingConfirmation = true }) {
          Image(systemName: "line.3.horizontal.decrease.circle")
        }
      }
    }
    .confirmationDialog(
      "",
      isPresented: $store.isShowingConfirmation)
    {
      Button(action: {
        store.send(.getItemList)
      }) {
        Text("Sort by added date")
      }

      Button(action: {
        store.send(.sortedByReleaseDate)
      }) {
        Text("Sort by release date")
      }

      Button(action: {
        store.send(.sortedByRating)
      }) {
        Text("Sort by ratings")
      }

      Button(action: {
        store.send(.sortedByPopularity)
      }) {
        Text("Sort by popularity")
      }
    } message: {
      Text("Sort movies by")
    }
    .onAppear {
      store.send(.getItemList)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
