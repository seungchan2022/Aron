import DesignSystem
import Domain
import SwiftUI

// MARK: - CrewPage.ItemComponent

extension CrewPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.MovieDetail.Credit.CrewItem) -> Void

    @Environment(\.colorScheme) var colorScheme

  }
}

extension CrewPage.ItemComponent { }

// MARK: - CrewPage.ItemComponent + View

extension CrewPage.ItemComponent: View {
  var body: some View {
    LazyVStack {
      ForEach(viewState.item.crewItemList) { item in
        Button(action: { tapAction(item) }) {
          VStack {
            HStack(spacing: 8) {
              RemoteImage(
                url: "https://image.tmdb.org/t/p/w500/\(item.profile ?? "")",
                placeholder: {
                  Rectangle()
                    .fill(.gray)
                })
                .scaledToFill()

                .frame(width: 60, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))

              VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                  .foregroundStyle(
                    colorScheme == .dark
                      ? DesignSystemColor.system(.white).color
                      : DesignSystemColor.system(.black).color)

                Text(item.job)
                  .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
                  .lineLimit(2)
                  .multilineTextAlignment(.leading)
              }

              Spacer()

              Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 8, height: 12)
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
            }
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()
              .padding(.leading, 72)
          }
        }
      }
      .padding(.horizontal, 16)

      .background(
        colorScheme == .dark
          ? DesignSystemColor.background(.black).color
          : DesignSystemColor.system(.white).color)
    }
    .background(
      colorScheme == .dark
        ? DesignSystemColor.background(.black).color
        : DesignSystemColor.system(.white).color)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .padding(.horizontal, 12)
  }
}

// MARK: - CrewPage.ItemComponent.ViewState

extension CrewPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.Credit.Response
  }
}
