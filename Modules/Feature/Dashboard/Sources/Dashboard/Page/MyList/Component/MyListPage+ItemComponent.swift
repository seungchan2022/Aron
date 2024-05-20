import DesignSystem
import Domain
import SwiftUI

// MARK: - MyListPage.ItemComponent

extension MyListPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void
    let swipeAction: (MovieEntity.MovieDetail.MovieCard.Response?) -> Void
    let deleteAction: (MovieEntity.MovieDetail.MovieCard.Response) -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    private let distance: CGFloat = 120
    @State private var color: Color = .white
  }
}

extension MyListPage.ItemComponent {
  private var remoteImageURL: String {
    "https://image.tmdb.org/t/p/w500/\(viewState.item.poster ?? "")"
  }
  
  private var releaseDate: String {
    viewState.item.releaseDate.toDate?.toString ?? ""
  }
  
  private var voteAverage: String {
    "\(Int((viewState.item.voteAverage ?? .zero) * 10))%"
  }
  
  private var voteAveragePercent: Double {
    Double(Int(viewState.item.voteAverage ?? .zero) * 10) / 100
  }
  
  private var voteAverageColor: Color {
    let voteAverage = Int((viewState.item.voteAverage ?? .zero) * 10)
    
    switch voteAverage {
    case 0..<25:
      return DesignSystemColor.tint(.red).color
    case 25..<50:
      return DesignSystemColor.tint(.orange).color
    case 50..<75:
      return DesignSystemColor.tint(.yellow).color
    default:
      return DesignSystemColor.tint(.green).color
    }
  }
}

// MARK: - MyListPage.ItemComponent + View

extension MyListPage.ItemComponent: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(color)
        .overlay(alignment: .trailing) {
          Button(action: { deleteAction(viewState.item) }) {
            Image(systemName: "trash")
              .resizable()
              .frame(width: 30, height: 30)
              .padding(.horizontal, 16)
              .tint(.white)
          }
        }
      
      VStack {
        HStack(spacing: 8) {
          RemoteImage(
            url: remoteImageURL,
            placeholder: {
              Rectangle()
                .fill(.gray)
            })
          .scaledToFill()
          .frame(width: 100, height: 160)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .shadow(radius: 5)
          
          VStack(alignment: .leading, spacing: 16) {
            Text(viewState.item.title)
              .font(.system(size: 18))
              .foregroundStyle(DesignSystemColor.label(.ocher).color)
              .multilineTextAlignment(.leading)
            
            HStack {
              Circle()
                .trim(from: .zero, to: voteAveragePercent)
                .stroke(
                  voteAverageColor,
                  style: .init(
                    lineWidth: 2,
                    lineCap: .butt,
                    lineJoin: .miter,
                    miterLimit: .zero,
                    dash: [1, 1.5],
                    dashPhase: .zero))
                .shadow(color: voteAverageColor, radius: 5)
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(-90))
                .overlay {
                  Text(voteAverage)
                    .font(.system(size: 14))
                    .foregroundStyle(
                      colorScheme == .dark
                      ? DesignSystemColor.system(.white).color
                      : DesignSystemColor.system(.black).color)
                }
              
              Text(releaseDate)
                .font(.system(size: 16))
                .foregroundStyle(
                  colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)
            }
            
            if let overview = viewState.item.overview {
              Text(overview)
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.top, 16)
        
        Divider()
          .padding(.leading, 120)
      }
      .onTapGesture {
        swipeAction(.none)
        tapAction(viewState.item)
      }
      .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
      .background(
        colorScheme == .dark
        ? DesignSystemColor.background(.black).color
        : DesignSystemColor.system(.white).color)
      .offset(x: viewState.isEdit ? -64 : .zero)
      .animation(.interactiveSpring(), value: viewState.isEdit)
      .gesture(
        DragGesture()
          .onChanged { value in
            guard let direction = value.translation.width.convert(distance: distance) else { return }
            switch direction {
            case .hiding: swipeAction(.none)
            case .showing: swipeAction(viewState.item)
            }
          }
      )
      .task {
        let _ = try? await Task.sleep(for: .seconds(1))
        color = .red
      }
    }
  }
}

// MARK: - MyListPage.ItemComponent.ViewState

extension MyListPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MovieEntity.MovieDetail.MovieCard.Response
    
    let isEdit: Bool
  }
  
  fileprivate enum Direction: Equatable {
    case showing
    case hiding
  }
}

extension CGFloat {
  fileprivate func convert(distance: CGFloat) -> MyListPage.ItemComponent.Direction? {
    if self > distance { return .hiding }
    else if self < -distance { return .showing }
    else { return .none }
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
