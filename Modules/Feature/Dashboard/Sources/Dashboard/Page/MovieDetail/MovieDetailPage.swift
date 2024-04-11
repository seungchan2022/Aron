import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - MovieDetailPage

struct MovieDetailPage {
  @Bindable var store: StoreOf<MovieDetailReducer>
  @Environment(\.colorScheme) var colorScheme

  @State private var isReadMoreTapped = false
}

extension MovieDetailPage {
  private var navigationTitle: String {
    store.state.fetchDetailItem.value?.title ?? ""
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
            tapGenreAction: { })
        }

        // List 버튼들
        if let item = store.fetchDetailItem.value {
          ListButtonComponent(
            viewState: .init(
              isWish: store.fetchIsWish.value,
              isSeen: store.fetchIsSeen.value,
              item: item),
            wishAction: { store.send(.updateIsWish($0)) },
            seenAction: { store.send(.updateIsSeen($0)) })
        }

        // Review
        if let item = store.fetchReviewItem.value {
          ReviewComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToReview($0)) })
        }

        // Overview
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

      // Section2 (Keyword ~ Images)
      VStack {
        // Keyword
        if let item = store.fetchDetailItem.value {
          KeywordItemListComponent(
            viewState: .init(item: item),
            tapAction: { })
        }

        // cast
        if
          let item = store.fetchCreditItem.value,
          let movieID = store.fetchDetailItem.value
        {
          CastItemListComponent(
            viewState: .init(item: item, movieID: movieID),
            tapSeaAllAction: { store.send(.routeToCastList($0)) },
            tapCastAction: { store.send(.routeToCastItem($0)) })
        }

        // Director
        if let item = store.fetchCreditItem.value {
          DirectorComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToCrewItem($0)) })
        }

        // Crew
        if
          let item = store.fetchCreditItem.value,
          let movieID = store.fetchDetailItem.value
        {
          CrewItemListComponent(
            viewState: .init(item: item, movieID: movieID),
            tapSeeAllAction: { store.send(.routeToCrewList($0)) },
            tapCrewAction: { store.send(.routeToCrewItem($0)) })
        }

        // SimilarMovie
        if
          let movieID = store.fetchDetailItem.value,
          let item = store.fetchSimilarMovieItem.value
        {
          SimilarMovieItemListComponent(
            viewState: .init(item: item, movieID: movieID),
            tapSeeAllAction: { store.send(.routeToSimilarMovieList($0)) },
            tapSimilarMovieAction: { store.send(.routeToSimilarMovie($0)) })
        }

        // RecommendedMovie
        if
          let movieID = store.fetchDetailItem.value,
          let item = store.fetchRecommendedMovieItem.value
        {
          RecommendedMovieItemListComponent(
            viewState: .init(item: item, movieID: movieID),
            tapSeeAllAction: { store.send(.routeToRecommendedMovieList($0)) },
            tapRecommendedMovieAction: { store.send(.routeToRecommendedMovie($0)) })
        }

        // OtherPoster
        if let item = store.fetchDetailItem.value {
          OtherPosterItemListComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToOtherPoster($0)) })
        }

        // Image
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
    .onChange(of: store.fetchDetailItem.value) { _, new in
      store.send(.getIsWishLike(new))
      store.send(.getIsSeenLike(new))
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
