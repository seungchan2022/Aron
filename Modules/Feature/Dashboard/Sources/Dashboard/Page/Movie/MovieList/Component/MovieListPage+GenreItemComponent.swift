import SwiftUI
import DesignSystem
import Domain

extension MovieListPage {
  struct GenreItemComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.Movie.GenreList.Item) -> Void
    
    @Environment(\.colorScheme) var colorScheme
  }
}

extension MovieListPage.GenreItemComponent {
  
}

extension MovieListPage.GenreItemComponent: View {
  var body: some View {
    ScrollView {
      LazyVStack(spacing: .zero) {
        ForEach(viewState.item.itemList) { item in
          Button(action: { tapAction(item) }) {
            VStack {
              HStack {
                Text(item.name)
                  .foregroundStyle(
                    colorScheme == .dark
                    ? DesignSystemColor.system(.white).color
                    : DesignSystemColor.system(.black).color
                  )
                
                Spacer()
                
                Image(systemName: "chevron.right")
                  .resizable()
                  .frame(width: 8, height: 12)
                  .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                  .padding(.trailing, 16)
              }
              
              Divider()
            }
            .padding(.leading, 16)
          }
          .padding(4)
        }
      }
    }
  }
}

extension MovieListPage.GenreItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.Movie.GenreList.Response
  }
}
