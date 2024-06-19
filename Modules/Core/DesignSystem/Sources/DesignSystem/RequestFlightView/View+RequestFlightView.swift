import SwiftUI

extension View {
  
  @ViewBuilder
  public func setRequestFlightView(isLoading: Bool) -> some View {
    overlay(alignment: .center) {
      if isLoading {
        ProgressView("Loading")
          .progressViewStyle(.circular)
          .controlSize(.large)
          .unredacted()
      }
    }
  }
}
