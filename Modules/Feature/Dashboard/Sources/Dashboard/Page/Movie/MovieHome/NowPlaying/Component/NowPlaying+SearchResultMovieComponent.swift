import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - NowPlayingPage.SearchResultMovieComponent

extension NowPlayingPage {
  struct SearchResultMovieComponent {
    let viewState: ViewState
    let tapAction: () -> Void

    @Bindable var store: StoreOf<NowPlayingReducer>
    @Environment(\.colorScheme) var colorScheme
  }
}

extension NowPlayingPage.SearchResultMovieComponent { }

// MARK: - NowPlayingPage.SearchResultMovieComponent + View

extension NowPlayingPage.SearchResultMovieComponent: View {

  @ViewBuilder
  var keyword: some View {
    LazyVStack(alignment: .leading) {
      Text("Keywords")
        .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
        .padding(.top, 16)

      if !viewState.keywordItemList.isEmpty {
        Divider()
      }

      ForEach(viewState.keywordItemList, id: \.keyword) { item in
        Button(action: { tapAction() }) {
          HStack {
            Text(item.keyword)
              .font(.system(size: 16))
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)

            Spacer()

            Image(systemName: "chevron.right")
              .resizable()
              .frame(width: 8, height: 12)
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
              .padding(.trailing, 16)
          }
        }
        Divider()
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading, 16)
  }

  @ViewBuilder
  var movie: some View {
    LazyVStack(alignment: .leading, spacing: 16) {
      Text("Result for \(store.query)")
        .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
        .padding(.top, 16)

      Divider()
        .padding(.top, -8)

      if viewState.movieItemList.isEmpty {
        Text("No Results")
          .font(.system(size: 18))
          .foregroundStyle(colorScheme == .dark ? DesignSystemColor.system(.white).color : DesignSystemColor.system(.black).color)
          .padding(.top, -8)

        Divider()

        Divider()
          .padding(.top, 24)
      }

      ForEach(viewState.movieItemList) { item in
        Button(action: { }) {
          VStack {
            HStack(spacing: 8) {
              Rectangle()
                .fill(.gray)
                .frame(width: 100, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 10))

              VStack(alignment: .leading, spacing: 16) {
                Text(item.title)
                  .font(.system(size: 18))
                  .foregroundStyle(DesignSystemColor.label(.ocher).color)

                HStack {
                  Text("\(Int(item.voteAverage * 10))%")
                    .font(.system(size: 18))
                    .foregroundStyle(
                      colorScheme == .dark
                        ? DesignSystemColor.system(.white).color
                        : DesignSystemColor.system(.black).color)

                  Text(item.releaseDate.toDate?.toString ?? "")
                    .font(.system(size: 16))
                    .foregroundStyle(
                      colorScheme == .dark
                        ? DesignSystemColor.system(.white).color
                        : DesignSystemColor.system(.black).color)
                }

                if let overView = item.overView {
                  Text(overView)
                    .font(.system(size: 18))
                    .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                }
              }

              Spacer()

              Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 8, height: 12)
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                .padding(.trailing, 16)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()
              .padding(.leading, 120)
          }
        }
      }
    }
    .padding(.leading, 16)
  }

  var body: some View {
    ScrollView {
      VStack {
        keyword
        movie
      }
    }
  }
}

extension NowPlayingPage.SearchResultMovieComponent {
  struct ViewState: Equatable {
    let keywordItemList: [KeywordItem]
    let movieItemList: [MovieItem]
  }

  struct KeywordItem: Equatable {
    let keyword: String
  }

  struct MovieItem: Equatable, Identifiable {
    let id: Int
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let overView: String?
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
    displayFormatter.dateFormat = "MMM d, yyyy"
    return displayFormatter.string(from: self)
  }
}
