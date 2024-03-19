import DesignSystem
import SwiftUI

// MARK: - MovieDetailPage.DirectorComponent

extension MovieDetailPage {
  struct DirectorComponent {
    let viewState: ViewState
    let tapAction: () -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieDetailPage.DirectorComponent { }

// MARK: - MovieDetailPage.DirectorComponent + View

extension MovieDetailPage.DirectorComponent: View {
  var body: some View {
    if let director = viewState.crewList.first(where: { $0.job == "Director" }) {
      Divider()
        .padding(.leading, 16)

      Button(action: {
        tapAction()
      }) {
        HStack {
          Text("Director: ")
            .font(.system(size: 16))
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color) +
            Text(director.name)
            .font(.system(size: 16))
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)

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

extension MovieDetailPage.DirectorComponent {
  struct ViewState: Equatable {
    let crewList: [CrewItem]
  }

  struct CrewItem: Equatable, Identifiable {
    let id: Int
    let job: String
    let name: String
  }
}
