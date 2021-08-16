import Foundation
import TMDBSwift

protocol MovieServiceProtocol {
    func loadGenres(completion: @escaping (Result<[GenresMDB], Error>) -> Void)
    func loadMovies(genre: String, page: Int, completion: @escaping (Result<[MovieMDB], Error>) -> Void)
}

final class MovieService: MovieServiceProtocol {
    private let apiLanguage = "en"
    private let apiKey = "0b1a18e2b899d214aba36f03889b819e"

    init() {
        TMDBConfig.apikey = apiKey
    }

    func loadGenres(completion: @escaping (Result<[GenresMDB], Error>) -> Void) {
        GenresMDB.genres(listType: .movie, language: apiLanguage) { result, genres in
            if let data = genres {
                completion(.success(data))
            } else if let err = result.error {
                completion(.failure(err))
            }
        }
    }

    func loadMovies(genre: String, page: Int, completion: @escaping (Result<[MovieMDB], Error>) -> Void) {
        DiscoverMDB.discover(discoverType: .movie, params: [.with_genres(genre), .page(page)]) { result, movies, _ in
            if let data = movies {
                completion(.success(data))
            } else if let err = result.error {
                completion(.failure(err))
            }
        }
    }
}
