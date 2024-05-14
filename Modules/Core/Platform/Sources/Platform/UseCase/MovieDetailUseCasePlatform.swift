import Combine
import Domain

// MARK: - MovieDetailUseCasePlatform

public struct MovieDetailUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://api.themoviedb.org/3/movie") {
    self.baseURL = baseURL
  }
}

// MARK: MovieDetailUseCase

extension MovieDetailUseCasePlatform: MovieDetailUseCase {
  public var movieCard: (MovieEntity.MovieDetail.MovieCard.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.MovieCard.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.movieID)"],
        httpMethod: .get,
        content: .queryItemPath(MovieCardQueryItem()))
        .fetch(isDebug: true)
    }
  }

  public var review: (MovieEntity.MovieDetail.Review.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.Review.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.movieID)", "reviews"],
        httpMethod: .get,
        content: .queryItemPath(DetailQueryItem()))
        .fetch(isDebug: true)
    }
  }

  public var credit: (MovieEntity.MovieDetail.Credit.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.Credit.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.movieID)", "credits"],
        httpMethod: .get,
        content: .queryItemPath(DetailQueryItem()))
        .fetch(isDebug: true)
    }
  }

  public var similarMovie: (MovieEntity.MovieDetail.SimilarMovie.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.SimilarMovie.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.movieID)", "similar"],
        httpMethod: .get,
        content: .queryItemPath(DetailQueryItem()))
        .fetch(isDebug: true)
    }
  }

  public var recommendedMovie: (MovieEntity.MovieDetail.RecommendedMovie.Request) -> AnyPublisher<
    MovieEntity.MovieDetail.RecommendedMovie.Response,
    CompositeErrorRepository
  > {
    { item in
      Endpoint(
        baseURL: baseURL,
        pathList: ["\(item.movieID)", "recommendations"],
        httpMethod: .get,
        content: .queryItemPath(DetailQueryItem()))
        .fetch(isDebug: true)
    }
  }
}

extension MovieDetailUseCasePlatform {
  fileprivate struct MovieCardQueryItem: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "ko-KR",
      includeImageLanguage: String? = "ko,ko,null",
      appendToResponse: String? = "keywords,images")
    {
      self.apiKey = apiKey
      self.language = language
      self.includeImageLanguage = includeImageLanguage
      self.appendToResponse = appendToResponse
    }

    // MARK: Public

    public let apiKey: String
    public let language: String
    public let includeImageLanguage: String?
    public let appendToResponse: String?

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case includeImageLanguage = "include_image_language"
      case appendToResponse = "append_to_response"
    }
  }

  fileprivate struct DetailQueryItem: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      apiKey: String = "1d9b898a212ea52e283351e521e17871",
      language: String = "en-US")
    {
      self.apiKey = apiKey
      self.language = language
    }

    // MARK: Public

    public let apiKey: String
    public let language: String

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language

    }
  }
}
