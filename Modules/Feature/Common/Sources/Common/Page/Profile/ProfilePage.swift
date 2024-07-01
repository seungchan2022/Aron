import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - ProfilePage

struct ProfilePage {
  @Bindable var store: StoreOf<ProfileReducer>

  @Environment(\.colorScheme) var colorScheme

}

extension ProfilePage {
  private var navigationTitle: String {
    store.fetchItem.value?.name ?? ""
  }

  private var isLoading: Bool {
    store.fetchItem.isLoading
      || store.fetchProfileImage.isLoading
      || store.fetchMovieCreditItem.isLoading
  }
}

// MARK: View

extension ProfilePage: View {
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .zero) {
        if let item = store.fetchItem.value {
          InfoComponent(
            viewState: .init(item: item),
            store: store)
        }

        if let item = store.fetchProfileImage.value {
          ImageComponent(viewState: .init(item: item))
        }
      }
      .padding(.vertical, 16)
      .background(
        colorScheme == .dark
          ? DesignSystemColor.background(.black).color
          : DesignSystemColor.system(.white).color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 12)

      VStack(alignment: .leading, spacing: 24) {
        if let item = store.fetchMovieCreditItem.value {
          CastItemListComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToCastDetail($0)) })
        }

        if let item = store.fetchMovieCreditItem.value {
          CrewItemListComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToCrewDetail($0)) })
        }
      }
      .padding(.top, 24)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv200)).color)
    .navigationTitle(navigationTitle)
    .navigationBarTitleDisplayMode(.large)
    .setRequestFlightView(isLoading: isLoading)
    .redacted(reason: isLoading ? .placeholder : [])
    .onAppear {
      store.send(.getItem(store.item))
      store.send(.getProfileImage(store.profileImageItem))
      store.send(.getMovieCreditItem(store.movieCreditItem))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
