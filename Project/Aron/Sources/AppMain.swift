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
            title: "Repository",
            image: .init(systemName: "shippingbox.fill"), tag: .zero),
          linkItem: .init(path: "repo"),
          prefersLargeTitles: true),

        .init(
          tag: 1,
          tabItem: .init(
            title: "User",
            image: .init(systemName: "person.3.fill"),
            tag: 1),
          linkItem: .init(path: "user"),
          prefersLargeTitles: true),


      ])
      .ignoresSafeArea()
      .onAppear {
      }
  }
}
