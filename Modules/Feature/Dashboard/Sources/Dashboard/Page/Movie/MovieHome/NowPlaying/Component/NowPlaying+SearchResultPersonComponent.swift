import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - NowPlayingPage.SearchResultPersonComponent

extension NowPlayingPage {
  struct SearchResultPersonComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Search.Person.Item) -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
  }
}

extension NowPlayingPage.SearchResultPersonComponent {
  private var remoteImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.profileImageURL ?? "")"
  }
}

// MARK: - NowPlayingPage.SearchResultPersonComponent + View

extension NowPlayingPage.SearchResultPersonComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      HStack(spacing: 12) {
        RemoteImage(
          url: remoteImageURL,
          placeholder: {
            Image(systemName: "person.fill")
              .resizable()
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv250)).color)
          })
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .frame(width: 80, height: 100)
        
        VStack(alignment: .leading) {
          Spacer()
          
          Text(viewState.item.name)
            .font(.system(size: 18))
            .foregroundStyle(DesignSystemColor.label(.ocher).color)
          
          Spacer()
          
          Text(viewState.item.filmList.map { $0.title ?? "" }.joined())
            .font(.system(size: 16))
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
            .multilineTextAlignment(.leading)
            .lineLimit(3)
          
          Spacer()
        }
        
        Spacer()
        
        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 8, height: 12)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          .padding(.trailing, 16)
      }
    }
  }
}

// MARK: - NowPlayingPage.SearchResultPersonComponent.ViewState

extension NowPlayingPage.SearchResultPersonComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Search.Person.Item
    
  }
}
