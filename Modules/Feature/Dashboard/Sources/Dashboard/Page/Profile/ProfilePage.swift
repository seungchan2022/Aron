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
}

// MARK: View

extension ProfilePage: View {
  var body: some View {
    ScrollView {
      // Section1
      VStack(alignment: .leading, spacing: .zero) {
        // profile ~ birth까지
        if let item = store.fetchItem.value {
          InfoComponent(
            viewState: .init(item: item),
            store: store)
        }
        
        // 이미지 컴포넌트 따로 분리
        if let item = store.fetchProfileImageItem.value {
          ImageComponent(viewState: .init(item: item))
        }
      }
      .padding(.vertical, 16)
      .background(
        colorScheme == .dark
        ? DesignSystemColor.background(.black).color
        : DesignSystemColor.system(.white).color)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .padding(.horizontal, 12) // 그룹의 패딩
      
      // Section2 해당 유저의 무비 리스트?
      
      VStack(alignment: .leading, spacing: 24) {
        // Cast
        VStack(alignment: .leading, spacing: .zero) {
          Text("Cast")
            .font(.title)
            .fontWeight(.bold)
            .padding(.leading, 32)
          
          LazyVStack(alignment: .leading) {
            ForEach(store.fetchMovieCreditItem.value?.castItemList ?? []) { item in
              CastItemComponent(
                viewState: .init(item: item),
                tapAction: { store.send(.routeToCastDetail($0))})
            }
          }
          
          
          .background(
            colorScheme == .dark
            ? DesignSystemColor.background(.black).color
            : DesignSystemColor.system(.white).color)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .padding(.horizontal, 12) // 그룹의 패딩
        }
        
        // Crew
        VStack(alignment: .leading, spacing: .zero) {
          Text("Crew")
            .font(.title)
            .fontWeight(.bold)
            .padding(.leading, 32)
          
          LazyVStack(alignment: .leading) {
            ForEach(store.fetchMovieCreditItem.value?.crewItemList ?? []) { item in
              CrewItemComponent(
                viewState: .init(item: item),
                tapAction: { store.send(.routeToCrewDetail($0))})
            }
          }
          .background(
            colorScheme == .dark
            ? DesignSystemColor.background(.black).color
            : DesignSystemColor.system(.white).color)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .padding(.horizontal, 12) // 그룹의 패딩
        }
        
        
      }
      .padding(.top, 24)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv200)).color)
    .navigationTitle(navigationTitle)
    .navigationBarTitleDisplayMode(.large)
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
