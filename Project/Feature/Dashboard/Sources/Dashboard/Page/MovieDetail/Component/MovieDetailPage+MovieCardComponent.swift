import DesignSystem
import Domain
import SwiftUI

// MARK: - MovieDetailPage.MovieCardComponent

extension MovieDetailPage {
  struct MovieCardComponent {
    let viewState: ViewState
    let genreTapAction: () -> Void
    @Environment(\.colorScheme) var colorScheme

  }
}

extension MovieDetailPage.MovieCardComponent {
  private var releaseDate: String {
    viewState.item.releaseDate.toDate?.toString ?? ""
  }

  private var voteAverage: String {
    "\(Int(viewState.item.voteAverage * 10))%"
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
            Text(releaseDate)
              .font(.system(size: 16))

            Text(" • \(viewState.item.runtime) minutes")
              .font(.system(size: 16))

            Text(" • \(viewState.item.status)")
              .font(.system(size: 16))
          }

          Text(viewState.item.productionCountryList.first?.name ?? "")
            .font(.system(size: 16))

          HStack {
            Text(voteAverage)
              .font(.system(size: 14))

            Text("\(viewState.item.voteCount) ratings")
              .font(.system(size: 18))
          }
          .padding(.top, 8)
        }
        .foregroundStyle(DesignSystemColor.system(.white).color)
      }
      .padding(.leading, 8)

      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(viewState.item.genreItemList) { item in
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
    .background(.gray.opacity(0.8))
  }
}

// MARK: - MovieDetailPage.MovieCardComponent.ViewState

extension MovieDetailPage.MovieCardComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.Response
  }
}

extension String {
  fileprivate var toDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: self)
  }
}

extension Date {
  fileprivate var toString: String? {
    let displayFormatter = DateFormatter()
    displayFormatter.dateFormat = "yyyy"
    return displayFormatter.string(from: self)
  }
}
