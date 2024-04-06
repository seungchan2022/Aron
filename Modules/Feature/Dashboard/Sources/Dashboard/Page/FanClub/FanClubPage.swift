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
        
        if !store.itemList.isEmpty {
          LazyVStack {
            ForEach(store.itemList) { item in
              ItemComponent(
                viewState: .init(item: item),
                tapAction: { store.send(.routeToDetail($0)) }
              )
              
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
