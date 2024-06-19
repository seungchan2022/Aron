import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - DiscoverPage

struct DiscoverPage {
  @Bindable var store: StoreOf<DiscoverReducer>

}

extension DiscoverPage {
  private func minX(proxy: GeometryProxy) -> CGFloat {
    let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX

    return minX < .zero ? .zero : -minX
  }

  private func progress(proxy: GeometryProxy) -> CGFloat {
    let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
    let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? .zero

    let progress = (maxX / width) - 1.0

    return progress
  }

  private func scale(proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
    let progress = progress(proxy: proxy)

    return 1 - (progress * scale)
  }

  private func verticalOffset(proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
    let progress = progress(proxy: proxy)

    return -progress * offset
  }
  
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
  
  private var navigationTitle: String {
    "Discover"
  }
}

// MARK: View

extension DiscoverPage: View {
  var body: some View {
    VStack {
      GeometryReader { proxy in
        ScrollView(.horizontal) {
          HStack(spacing: .zero) {
            ForEach(store.itemList) { item in
              ItemComponent(
                viewState: .init(item: item),
                tapAction: { store.send(.routeToDetail($0)) })
                .onAppear {
                  guard let last = store.itemList.last, last.id == item.id else { return }
                  guard !store.fetchItem.isLoading else { return }
                  store.send(.getItem)
                }
                .padding(.horizontal, 64)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .visualEffect { content, geometryProxy in
                  content
                    .scaleEffect(scale(proxy: geometryProxy, scale: 0.1), anchor: .top)
                    .offset(x: minX(proxy: geometryProxy))
                    .offset(y: verticalOffset(proxy: geometryProxy, offset: 10))
                }
                .zIndex(store.itemList.zIndex(item: item))
            }
          }
          .padding(.vertical, 32)
        }
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
      }
      .frame(height: 450)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.top, -48)
    .background {
      RemoteImage(
        url: "https://image.tmdb.org/t/p/w500/\(store.itemList.randomElement()?.poster ?? "")",
        placeholder: {
          Rectangle()
            .fill(.gray)
        })

      Rectangle()
        .background(.ultraThinMaterial)

      //      ForEach(store.itemList) { item in
      //        RemoteImage(
      //          url: "https://image.tmdb.org/t/p/w500/\(item.poster ?? "")",
      //          placeholder: {
      //            Rectangle()
      //              .fill(.gray)
      //          }
      //        )
      //        Rectangle()
      //          .background(.ultraThinMaterial)
      //
      //      }
    }
    .ignoresSafeArea(.all)
    .navigationTitle(navigationTitle)
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}

extension [MovieEntity.Discover.Movie.Item] {
  fileprivate func zIndex(item: MovieEntity.Discover.Movie.Item) -> CGFloat {
    if let index = firstIndex(where: { $0.id == item.id }) {
      return CGFloat(count) - CGFloat(index)
    }

    return .zero
  }
}
