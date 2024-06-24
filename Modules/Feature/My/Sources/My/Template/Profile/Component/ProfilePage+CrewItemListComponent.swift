import DesignSystem
import Domain
import SwiftUI

// MARK: - ProfilePage.CrewItemListComponent

extension ProfilePage {
  struct CrewItemListComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Person.MovieCredit.CrewItem) -> Void

    @Environment(\.colorScheme) var colorScheme

  }
}

extension ProfilePage.CrewItemListComponent {
  private var filteredItemList: [MovieEntity.Person.MovieCredit.CrewItem] {
    viewState.item.crewItemList.reduce(into: [MovieEntity.Person.MovieCredit.CrewItem]()) { curr, next in
      guard !curr.contains(where: { $0.id == next.id }) else { return }
      curr = curr + [next]
    }
  }
}

// MARK: - ProfilePage.CrewItemListComponent + View

extension ProfilePage.CrewItemListComponent: View {
  var body: some View {
    if !viewState.item.crewItemList.isEmpty {
      VStack(alignment: .leading, spacing: .zero) {
        Text("Crew")
          .font(.title)
          .fontWeight(.bold)
          .padding(.leading, 32)

        LazyVStack(alignment: .leading) {
          ForEach(filteredItemList) { item in
            Button(action: { tapAction(item) }) {
              ItemComponent(crewItem: item)
            }
          }
        }
        .background(
          colorScheme == .dark
            ? DesignSystemColor.background(.black).color
            : DesignSystemColor.system(.white).color)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .padding(.horizontal, 12)
      }
    }
  }
}

// MARK: - ProfilePage.CrewItemListComponent.ViewState

extension ProfilePage.CrewItemListComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Person.MovieCredit.Response
  }
}

// MARK: - ProfilePage.CrewItemListComponent.ItemComponent

extension ProfilePage.CrewItemListComponent {
  fileprivate struct ItemComponent {
    let crewItem: MovieEntity.Person.MovieCredit.CrewItem

    @Environment(\.colorScheme) var colorScheme
  }
}

extension ProfilePage.CrewItemListComponent.ItemComponent {
  private var remoteImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(crewItem.poster ?? "")"
  }
}

// MARK: - ProfilePage.CrewItemListComponent.ItemComponent + View

extension ProfilePage.CrewItemListComponent.ItemComponent: View {
  var body: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 8) {
        RemoteImage(
          url: remoteImageURL,
          placeholder: {
            Image(systemName: "My.fill")
              .resizable()
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv250)).color)
          })
          .clipShape(RoundedRectangle(cornerRadius: 5))
          .frame(width: 80, height: 100)

        VStack(alignment: .leading, spacing: 8) {
          Text(crewItem.title)
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)
              .multilineTextAlignment(.leading)

          if let department = crewItem.department {
            Text(department)
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
              .multilineTextAlignment(.leading)
          }
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
    .padding(.horizontal, 16)
  }
}
