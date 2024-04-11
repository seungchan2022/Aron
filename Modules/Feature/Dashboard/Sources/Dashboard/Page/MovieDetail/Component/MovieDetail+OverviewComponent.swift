import DesignSystem
import Domain
import ComposableArchitecture
import SwiftUI

// MARK: - MovieDetailPage.OverviewComponent

extension MovieDetailPage {
  struct OverviewComponent {
    let viewState: ViewState

//    @Binding var isReadMoreTapped: Bool
    
    @Bindable var store: StoreOf<MovieDetailReducer>
  }
}

extension MovieDetailPage.OverviewComponent { }

// MARK: - MovieDetailPage.OverviewComponent + View

extension MovieDetailPage.OverviewComponent: View {
  var body: some View {
    if let overview = viewState.item.overview {
      Divider()
        .padding(.leading, 16)

      VStack(alignment: .leading, spacing: 8) {
        Text("Overview:")

        Text(overview)
          .font(.system(size: 16))
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
          .multilineTextAlignment(.leading)
          .lineLimit(store.isShowingReadMore ? .none : 4)

        Button(action: { store.isShowingReadMore.toggle() }) {
          Text(store.isShowingReadMore ? "Less" : "Read More")
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
