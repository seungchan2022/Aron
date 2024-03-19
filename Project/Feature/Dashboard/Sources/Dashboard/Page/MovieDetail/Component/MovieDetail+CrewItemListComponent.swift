import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.CrewItemListComponent

extension MovieDetailPage {
  struct CrewItemListComponent {
    let viewState: ViewState
    let tapAction: () -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.CrewItemListComponent { }

// MARK: - MovieDetailPage.CrewItemListComponent + View

extension MovieDetailPage.CrewItemListComponent: View {
  var body: some View {
    Divider()
      .padding(.leading, 16)

    VStack(spacing: .zero) {
      Button(action: { tapAction() }) {
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
          ForEach(viewState.item.crewItemList) { item in
            Button(action: { }) {
              VStack {
                Rectangle()
                  .fill(DesignSystemColor.palette(.gray(.lv250)).color)
                  .frame(width: 80, height: 120)
                  .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(item.name)
                  .font(.system(size: 16))
                  .foregroundStyle(
                    colorScheme == .dark
                      ? DesignSystemColor.system(.white).color
                      : DesignSystemColor.system(.black).color)
                    .lineLimit(1)

                Text(item.department)
                  .font(.system(size: 16))
                  .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
                  .lineLimit(1)
              }
            }
            .frame(width: 120)
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
