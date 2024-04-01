import Architecture
import ComposableArchitecture
import Foundation

// MARK: - MyListSideEffect

struct MyListSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType

  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension MyListSideEffect {
  var routeToNewList: () -> Void {
    {
      navigator.sheet(
        linkItem: .init(path: Link.Dashboard.Path.newList.rawValue),
        isAnimated: true)
    }
  }
}
