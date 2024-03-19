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

  private var reviewComponentViewState: ReviewComponent.ViewState {
    .init(id: 787699, totalResultListCount: 8)
  }

  private var castItemListComponentViewState: CastItemListComponent.ViewState {
    .init(castItemList: [
      .init(
        id: 1,
        name: "Chalamet",
        character: "Willy Wonka",
        profileImage: .none),
      .init(
        id: 2,
        name: "Calah Lane",
        character: "Noodle",
        profileImage: .none),

      .init(
        id: 3,
        name: "Hugh Grant",
        character: "Ooppa-Loompa / Lofty",
        profileImage: .none),

      .init(
        id: 4,
        name: "Paterson Jaseph",
        character: "Arthur Slugworth",
        profileImage: .none),
    ])
  }

  private var directorComponentViewState: DirectorComponent.ViewState {
    .init(crewList: [
      .init(id: 2, job: "Actor", name: "Alice"),
      .init(id: 5, job: "Director", name: "Mattew"),
    ])
  }

  private var crewItemListComponentViewState: CrewItemListComponent.ViewState {
    .init(crewItemList: [
      .init(
        id: 1,
        name: "Chalamet",
        department: "Writing",
        profileImage: .none),
      .init(
        id: 2,
        name: "Calah Lane",
        department: "Acting",
        profileImage: .none),

      .init(
        id: 3,
        name: "Hugh Grant",
        department: "Makeup Supe",
        profileImage: .none),

      .init(
        id: 4,
        name: "Paterson Jaseph",
        department: "Director of Photography",
        profileImage: .none),
    ])
  }

  private var similarMovieItemListComponentViewState: SimilarMovieItemListComponent.ViewState {
    .init(similarMovieList: [
      .init(id: 1, poster: .none, title: "similar movie1", voteAverage: 7.99),
      .init(id: 2, poster: .none, title: "similar movie2", voteAverage: 7.99),
      .init(id: 3, poster: .none, title: "similar movie3", voteAverage: 7.99),
      .init(id: 4, poster: .none, title: "similar movie4", voteAverage: 7.99),
      .init(id: 5, poster: .none, title: "similar movie5", voteAverage: 7.99),
      .init(id: 6, poster: .none, title: "similar movie6", voteAverage: 7.99),
    ])
  }

  private var recommendedMovieItemListComponentViewState: RecommendedMovieItemListComponent.ViewState {
    .init(recommendedMovieList: [
      .init(id: 1, poster: .none, title: "recommended movie1", voteAverage: 7.99),
      .init(id: 2, poster: .none, title: "recommended movie2", voteAverage: 7.99),
      .init(id: 3, poster: .none, title: "recommended movie3", voteAverage: 7.99),
      .init(id: 4, poster: .none, title: "recommended movie4", voteAverage: 7.99),
      .init(id: 5, poster: .none, title: "recommended movie5", voteAverage: 7.99),
      .init(id: 6, poster: .none, title: "recommended movie6", voteAverage: 7.99),
    ])
  }

  private var otherPosterItemListComponentViewState: OtherPosterItemListComponent.ViewState {
    .init(
      imageBucket: .init(
        posterItemList: [
          .init(id: 1, image: .none),
          .init(id: 2, image: .none),
          .init(id: 3, image: .none),
          .init(id: 4, image: .none),
          .init(id: 5, image: .none),
          .init(id: 6, image: .none),
          .init(id: 7, image: .none),
          .init(id: 8, image: .none),
          .init(id: 9, image: .none),
          .init(id: 10, image: .none),
        ]))
  }

  private var imageItemListComponent: ImageItemListComponent.ViewState {
    .init(
      imageBucket: .init(
        backdropImageList: [
          .init(id: 1, image: .none),
          .init(id: 2, image: .none),
          .init(id: 3, image: .none),
          .init(id: 4, image: .none),
          .init(id: 5, image: .none),
          .init(id: 6, image: .none),
          .init(id: 7, image: .none),
          .init(id: 8, image: .none),
          .init(id: 9, image: .none),
          .init(id: 10, image: .none),
        ]))
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

        // review
        ReviewComponent(
          viewState: reviewComponentViewState,
          tapAction: { })

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
        if let item = store.fetchDetailItem.value {
          KeywordItemListComponent(viewState: .init(item: item))
        }

        // cast
        CastItemListComponent(
          viewState: castItemListComponentViewState,
          tapAction: { })

        DirectorComponent(
          viewState: directorComponentViewState,
          tapAction: { })

        CrewItemListComponent(
          viewState: crewItemListComponentViewState,
          tapAction: { })

        SimilarMovieItemListComponent(
          viewState: similarMovieItemListComponentViewState,
          tapAction: { })

        RecommendedMovieItemListComponent(
          viewState: recommendedMovieItemListComponentViewState,
          tapAction: { })

        OtherPosterItemListComponent(
          viewState: otherPosterItemListComponentViewState,
          tapAction: { })

        ImageItemListComponent(
          viewState: imageItemListComponent,
          tapAction: { })
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
      store.send(.getDetail)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
