import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - MovieDetailPage

struct MovieDetailPage {
  @Bindable var store: StoreOf<MovieDetailReducer>
  @Environment(\.colorScheme) var colorScheme

  @State private var isReadMoreTapped = false
  @State private var isWishListButtonTapped = false
  @State private var isSeenListButtonTapped = false
  @State private var isShowingConfirmation = false
}

extension MovieDetailPage {
  private var navigationTitle: String {
    store.state.fetchDetailItem.value?.title ?? ""
  }

  private var listButtonComponentViewState: ListButtonComponent.ViewState {
    .init()
  }
}

// MARK: View

extension MovieDetailPage: View {
  var body: some View {
    ScrollView {
      // Section1 (MovieCard ~ OverView)
      VStack {
        // MovieCard
        if let item = store.fetchDetailItem.value {
          MovieCardComponent(
            viewState: .init(item: item),
            genreTapAction: { })
        }

        // List 버튼들
        ListButtonComponent(
          viewState: listButtonComponentViewState,
          isWishListButtonTapped: self.$isWishListButtonTapped,
          isSeenListButtonTapped: self.$isSeenListButtonTapped,
          isShowingConfirmation: self.$isShowingConfirmation)
//
        // review
        if let item = store.fetchReviewItem.value {
          ReviewComponent(
            viewState: .init(item: item),
            tapAction: { })
        }
//
//        // Overview
        if let item = store.fetchDetailItem.value {
          OverviewComponent(
            viewState: .init(item: item),
            isReadMoreTapped: self.$isReadMoreTapped)
        }
      }
      .background(
        colorScheme == .dark
          ? DesignSystemColor.background(.black).color
          : DesignSystemColor.system(.white).color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 12) // 그룹의 패딩
//
//      // Section2 (Keyword ~ Images)
      VStack {
        if let item = store.fetchDetailItem.value {
          KeywordItemListComponent(viewState: .init(item: item))
        }

        // cast
        if let item = store.fetchCreditItem.value {
          CastItemListComponent(
            viewState: .init(item: item),
            tapAction: { })
        }

        if let item = store.fetchCreditItem.value {
          DirectorComponent(
            viewState: .init(item: item),
            tapAction: { })
        }

        if let item = store.fetchCreditItem.value {
          CrewItemListComponent(
            viewState: .init(item: item),
            tapAction: { })
        }

        if let item = store.fetchSimilarMovieItem.value {
          SimilarMovieItemListComponent(
            viewState: .init(item: item),
            tapAction: { })
        }

        if let item = store.fetchRecommendedMovieItem.value {
          RecommendedMovieItemListComponent(
            viewState: .init(item: item),
            tapAction: { })
        }

        if let item = store.fetchDetailItem.value {
          OtherPosterItemListComponent(
            viewState: .init(item: item),
            tapAction: { _ in print(item) })
        }
        
        if let item = store.fetchDetailItem.value {
          ImageItemListComponent(viewState: .init(item: item))
        }
      }
      .background(
        colorScheme == .dark
          ? DesignSystemColor.background(.black).color
          : DesignSystemColor.system(.white).color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 12) // 그룹의 패딩
        .padding(.top, 24)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv200)).color)
    .navigationTitle(navigationTitle)
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { }) {
          Image(systemName: "text.badge.plus")
        }
      }
    }
    .onAppear {
      store.send(.getDetail(store.item))
      store.send(.getReview(store.reviewItem))
      store.send(.getCredit(store.creditItem))
      store.send(.getSimilarMovie(store.similarMovieItem))
      store.send(.getRecommendedMovie(store.recommendedMovieItem))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
