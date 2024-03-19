import DesignSystem
import SwiftUI

// MARK: - MovieDetailPage.MovieCardComponent

extension MovieDetailPage {
  struct MovieCardComponent {
    let viewState: ViewState
    let genreTapAction: () -> Void
    @Environment(\.colorScheme) var colorScheme

  }
}

// MARK: - MovieDetailPage.MovieCardComponent + View

extension MovieDetailPage.MovieCardComponent: View {
  var body: some View {
    VStack {
      HStack {
        Rectangle()
          .fill(DesignSystemColor.palette(.gray(.lv250)).color)
          .frame(width: 100, height: 140)
          .clipShape(RoundedRectangle(cornerRadius: 10))

        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Text(viewState.releaseDate)
              .font(.system(size: 16))

            Text(" • \(viewState.runtime) minutes")
              .font(.system(size: 16))

            Text(" • \(viewState.status)")
              .font(.system(size: 16))
          }

          Text(viewState.productionCountryList.first?.name ?? "")
            .font(.system(size: 16))

          HStack {
            Text("\(Int(viewState.voteAverage * 10))%")
              .font(.system(size: 14))

            Text("\(viewState.voteCount) ratings")
              .font(.system(size: 18))
          }
          .padding(.top, 8)
        }
        .foregroundStyle(DesignSystemColor.system(.white).color)
      }
      .padding(.leading, 8)

      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(viewState.genreList) { item in
            Button(action: { }) {
              HStack {
                Text(item.name)
                  .font(.system(size: 16))

                Image(systemName: "chevron.right")
                  .resizable()
                  .frame(width: 8, height: 12)
              }
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)
            }
            .tint(
              colorScheme == .dark
                ? DesignSystemColor.system(.black).color
                : DesignSystemColor.system(.white).color)
              .buttonStyle(.borderedProminent)
              .buttonBorderShape(.capsule)
              .controlSize(.small)
          }
        }
        .padding(.leading, 12)
        .padding(.vertical, 12)
        .padding(.top, 8)
      }
      .scrollIndicators(.hidden)
    }
    .padding(.vertical, 16)
    .frame(maxWidth: .infinity)
    .background(.gray.opacity(0.5))
  }
}

extension MovieDetailPage.MovieCardComponent {
  struct ViewState: Equatable {
    let poster: Image?
    let releaseDate: String
    let runtime: Int
    let status: String
    let productionCountryList: [ProductionContry]
    let voteAverage: Double
    let voteCount: Int
    let genreList: [GenreItem]
  }

  struct ProductionContry: Equatable {
    let name: String
  }

  struct GenreItem: Equatable, Identifiable {
    let id: Int
    let name: String
  }
}
