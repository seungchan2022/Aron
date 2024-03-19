import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.OverviewComponent

extension MovieDetailPage {
  struct OverviewComponent {
    let viewState: ViewState

    @Binding var isReadMoreTapped: Bool
  }
}

extension MovieDetailPage.OverviewComponent { }

// MARK: - MovieDetailPage.OverviewComponent + View

extension MovieDetailPage.OverviewComponent: View {
  var body: some View {
    if !viewState.item.overview.isEmpty {
      Divider()
        .padding(.leading, 16)

      VStack(alignment: .leading, spacing: 8) {
        Text("Overview:")

        Text(viewState.item.overview)
          .font(.system(size: 16))
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
          .multilineTextAlignment(.leading)
          .lineLimit(self.isReadMoreTapped ? .none : 4)

        Button(action: { self.isReadMoreTapped.toggle() }) {
          Text(self.isReadMoreTapped ? "Less" : "Read More")
            .foregroundStyle(DesignSystemColor.label(.greenSlate).color)
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 4)
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

// MARK: - MovieDetailPage.OverviewComponent.ViewState

extension MovieDetailPage.OverviewComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.Response
  }
}
