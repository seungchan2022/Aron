import Architecture
import ComposableArchitecture
import Foundation

// MARK: - NowPlayingSideEffect

struct NowPlayingSideEffect {
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

extension NowPlayingSideEffect {
  var routeToDetail: () -> Void {
    {
      navigator.next(
        linkItem: .init(path: Link.Dashboard.Path.movieDetail.rawValue),
        isAnimated: true)
    }
  }
}
