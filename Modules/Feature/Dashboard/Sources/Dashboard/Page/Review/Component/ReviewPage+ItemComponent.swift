import SwiftUI
import Domain
import DesignSystem

extension ReviewPage {
  struct ItemComponent {
    let viewSate: ViewState
    
    @Environment(\.colorScheme) var colorScheme
  }
}


extension ReviewPage.ItemComponent {
}

extension ReviewPage.ItemComponent: View {
  var body: some View {
    LazyVStack {
      ForEach(viewSate.item.itemList, id: \.author) { item in
        VStack(alignment: .leading, spacing: 16) {
          Text("Review written by \(item.author)")
            .fontWeight(.bold)
          
          Text(item.content)
          
          Divider()
        }
      }
      .padding(16)
      
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

extension ReviewPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.Review.Response
  }
}
