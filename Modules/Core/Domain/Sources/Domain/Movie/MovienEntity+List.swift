import Foundation

extension MovieEntity {
  public struct List: Equatable, Codable, Sendable {
    public let wishList: [MovieEntity.MovieDetail.MovieCard.Response]
    public let seenList: [MovieEntity.MovieDetail.MovieCard.Response]

    public init(
      wishList: [MovieEntity.MovieDetail.MovieCard.Response] = [],
      seenList: [MovieEntity.MovieDetail.MovieCard.Response] = [])
    {
      self.wishList = wishList
      self.seenList = seenList
    }
  }
}
