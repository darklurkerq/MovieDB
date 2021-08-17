import Foundation

protocol ListByGenresInteractorInput: class {
    func loadGenres(completion: @escaping (Result<[GenreViewModel], Error>) -> Void)
    func loadMovies(genre: String, page: Int, completion: @escaping (Result<[MovieViewModel], Error>) -> Void)
}

final class ListByGenresInteractor {
    @Injected
    var service: MovieServiceProtocol
    private var genreCache = Cache<[GenreViewModel]>()
}

extension ListByGenresInteractor: ListByGenresInteractorInput {
    func loadMovies(genre: String, page: Int, completion: @escaping (Result<[MovieViewModel], Error>) -> Void) {
        service.loadMovies(genre: genre, page: page) { result in
            switch result {
            case .success(let data):
                let movies = data.compactMap({ rawData -> MovieViewModel? in
                    guard let imageUrl = rawData.poster_path, let title = rawData.title else {
                        return nil
                    }
                    return MovieViewModel(image: imageUrl, title: title)
                })
                completion(.success(movies))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    func loadGenres(completion: @escaping (Result<[GenreViewModel], Error>) -> Void) {
        if let stored = genreCache.loadData() {
            completion(.success(stored))
        } else {
            service.loadGenres { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    let genres = data.compactMap { rawData -> GenreViewModel? in
                        guard let genreID = rawData.id, let genreTitle = rawData.name else {
                            return nil
                        }
                        return GenreViewModel(identifier: genreID, title: genreTitle)
                    }
                    self.genreCache.saveData(genres)
                    completion(.success(genres))
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        }
    }
}
