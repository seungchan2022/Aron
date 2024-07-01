import Architecture
import LinkNavigator
import SwiftUI

// MARK: - AppMain

struct AppMain {
  let viewModel: AppViewModel
}

// MARK: View

extension AppMain: View {

  var body: some View {
    TabLinkNavigationView(
      linkNavigator: viewModel.linkNavigator,
      isHiddenDefaultTabbar: false,
      tabItemList: [
        .init(
          tag: .zero,
          tabItem: .init(
            title: "Movie",
            image: .init(systemName: "film.fill"),
            tag: .zero),
          linkItem: .init(path: Link.Movie.Path.home.rawValue),
          prefersLargeTitles: true),

        .init(
          tag: 1,
          tabItem: .init(
            title: "Discover",
            image: .init(systemName: "square.stack.fill"),
            tag: 1),
          linkItem: .init(path: Link.Movie.Path.discover.rawValue),
          prefersLargeTitles: true),

        .init(
          tag: 2,
          tabItem: .init(
            title: "FanClub",
            image: .init(systemName: "star.circle.fill"),
            tag: 2),
          linkItem: .init(path: Link.Credit.Path.fanClub.rawValue),
          prefersLargeTitles: true),

        .init(
          tag: 3,
          tabItem: .init(
            title: "MyList",
            image: .init(systemName: "heart.circle.fill"),
            tag: 3),
          linkItem: .init(path: Link.My.Path.myList.rawValue),
          prefersLargeTitles: true),
      ])
      .ignoresSafeArea()
      .onAppear { }
  }
}
