import Architecture
import ComposableArchitecture
import Foundation
import Domain

struct SimilarSideEffect {
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

extension SimilarSideEffect { }