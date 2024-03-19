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
  private var movieCardComponentViewState: MovieCardComponent.ViewState {
    .init(
      poster: .none,
      releaseDate: "2023",
      runtime: 117,
      status: "Released",
      productionCountryList: [
        .init(name: "United Kingdom"),
        .init(name: "United States of America"),
      ],
      voteAverage: 7.202,
      voteCount: 2556,
      genreList: [
        .init(id: 35, name: "Comedy"),
        .init(id: 10751, name: "Family"),
        .init(id: 14, name: "Fantasy"),
      ])
  }

  private var listButtonComponentViewState: ListButtonComponent.ViewState {
    .init()
  }

  private var reviewComponentViewState: ReviewComponent.ViewState {
    .init(id: 787699, totalResultListCount: 8)
  }

  private var overviewComponentViewState: OverviewComponent.ViewState {
    //    .init(overview: "마법사이자 초콜릿 메이커 ‘윌리 웡카’의 꿈은 디저트의 성지, ‘달콤 백화점’에 자신만의 초콜릿 가게를 여는 것. 가진 것이라고는 낡은 모자 가득한 꿈과 단돈 12소베른 뿐이지만 특별한 마법의 초콜릿으로 사람들을 사로잡을 자신이 있다. 하지만 먹을 것도, 잠잘 곳도, 의지할 사람도 없는 상황 속에서 낡은 여인숙에 머물게 된 ‘웡카’는 ‘스크러빗 부인’과 ‘블리처’의 계략에 빠져 눈더미처럼 불어난 숙박비로 인해 순식간에 빚더미에 오른다. 게다가 밤마다 초콜릿을 훔쳐가는 작은 도둑 ‘움파 룸파’의 등장과 ‘달콤 백화점’을 독점한 초콜릿 카르텔의 강력한 견제까지. 세계 최고의 초콜릿 메이커가 되는 길은 험난하기만 한데…")
    .init(overview: "")
  }

  private var keywordItemListComponentViewState: KeywordItemListComponent.ViewState {
    .init(
      keywordBucket: .init(
        keywordItem: [
          .init(id: 715, name: "chocolate"),
          .init(id: 4344, name: "musical"),
          .init(id: 9675, name: "prequel"),
          .init(id: 179431, name: "duringcrditsstinger"),
          .init(id: 206594, name: "cartel"),
          .init(id: 324713, name: "whimsical"),
        ]))
//    .init(keywordBucket: .init(keywordItem: []))
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
        MovieCardComponent(
          viewState: movieCardComponentViewState,
          genreTapAction: { })

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
        OverviewComponent(
          viewState: overviewComponentViewState,
          isReadMoreTapped: self.$isReadMoreTapped)
      }
      .background(
        colorScheme == .dark
          ? DesignSystemColor.background(.black).color
          : DesignSystemColor.system(.white).color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 12) // 그룹의 패딩

      // Section2 (Keyword ~ Images)
      VStack {
        KeywordItemListComponent(viewState: keywordItemListComponentViewState)

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
    .navigationTitle("Movie Title")
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { }) {
          Image(systemName: "text.badge.plus")
        }
      }
    }
  }
}
