import DesignSystem
import SwiftUI

// MARK: - MovieDetailPage.ReviewComponent

extension MovieDetailPage {
  struct ReviewComponent {
    let viewState: ViewState
    let tapAction: () -> Void
  }
}

extension MovieDetailPage.ReviewComponent { }

// MARK: - MovieDetailPage.ReviewComponent + View

extension MovieDetailPage.ReviewComponent: View {
  var body: some View {
    if viewState.totalResultListCount != .zero {
      Divider()
        .padding(.leading, 48)

      Button(action: { }) {
        HStack {
          Text("\(viewState.totalResultListCount) reviews")
            .foregroundStyle(DesignSystemColor.label(.greenSlate).color)

          Spacer()

          Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 8, height: 12)
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
      }
    }
  }
}

// MARK: - MovieDetailPage.ReviewComponent.ViewState

extension MovieDetailPage.ReviewComponent {
  struct ViewState: Equatable, Identifiable {
    let id: Int
    let totalResultListCount: Int
  }
}
