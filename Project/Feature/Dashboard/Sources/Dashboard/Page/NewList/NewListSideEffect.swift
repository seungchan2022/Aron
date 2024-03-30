import Architecture
import ComposableArchitecture
import Foundation

struct NewListSideEffect {
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

extension NewListSideEffect {
  var routeToBack: () -> Void {
    {
      navigator.close(isAnimated: true, completeAction: { })
    }
  }
}
