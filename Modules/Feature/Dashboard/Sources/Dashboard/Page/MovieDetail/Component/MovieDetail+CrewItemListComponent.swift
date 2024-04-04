import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.CrewItemListComponent

extension MovieDetailPage {
  struct CrewItemListComponent {
    let viewState: ViewState
    let tapSeeAllAction: (MovieEntity.MovieDetail.Credit.Response) -> Void
    let tapCrewAction: (MovieEntity.MovieDetail.Credit.CrewItem) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.CrewItemListComponent {

  private var filteredItemList: [MovieEntity.MovieDetail.Credit.CrewItem] {
    viewState.item.crewItemList.reduce(into: [MovieEntity.MovieDetail.Credit.CrewItem]()) { curr, next in
      guard !curr.contains(where: { $0.id == next.id }) else { return }
      curr = curr + [next]
    }
  }

}

// MARK: - MovieDetailPage.CrewItemListComponent + View

extension MovieDetailPage.CrewItemListComponent: View {
  var body: some View {
    Divider()
      .padding(.leading, 16)

    VStack(spacing: .zero) {
      Button(action: {
        tapSeeAllAction(viewState.item)
      }) {
        HStack {
          Text("Crew")
            .font(.system(size: 16))
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)

          Text("See all")
            .font(.system(size: 16))
            .foregroundStyle(DesignSystemColor.label(.greenSlate).color)

          Spacer()

          Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 8, height: 12)
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
        }
        .padding(.top, 4)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
      }

      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(filteredItemList) { item in
            Button(action: { tapCrewAction(item) }) {
              ItemComponent(crewItem: item)
            }
          }
        }
        .padding(.leading, 12)
      }
      .padding(.top, 12)
      .scrollIndicators(.hidden)
    }
    .padding(.bottom, 12)
  }
}

// MARK: - MovieDetailPage.CrewItemListComponent.ViewState

extension MovieDetailPage.CrewItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.Credit.Response
  }
}

// MARK: - MovieDetailPage.CrewItemListComponent.ItemComponent

extension MovieDetailPage.CrewItemListComponent {
  fileprivate struct ItemComponent {
    let crewItem: MovieEntity.MovieDetail.Credit.CrewItem

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.CrewItemListComponent.ItemComponent {
  private var profileImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(crewItem.profile ?? "")"
  }
}

// MARK: - MovieDetailPage.CrewItemListComponent.ItemComponent + View

extension MovieDetailPage.CrewItemListComponent.ItemComponent: View {
  var body: some View {
    VStack {
      RemoteImage(
        url: profileImageURL,
        placeholder: {
          Rectangle()
            .fill(DesignSystemColor.palette(.gray(.lv250)).color)
        })
        .scaledToFill()
        .frame(width: 80, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 10))
      Text(crewItem.name)
        .font(.system(size: 16))
        .foregroundStyle(
          colorScheme == .dark
            ? DesignSystemColor.system(.white).color
            : DesignSystemColor.system(.black).color)
          .lineLimit(1)

      Text(crewItem.department)
        .font(.system(size: 16))
        .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
        .lineLimit(1)
    }
    .frame(width: 120)
  }
}
