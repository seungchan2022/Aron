import Combine

public protocol FanClubUseCase {
  var fanClub: (MovieEntity.FanClub.Request) -> AnyPublisher<MovieEntity.FanClub.Response, CompositeErrorRepository> { get }
}
