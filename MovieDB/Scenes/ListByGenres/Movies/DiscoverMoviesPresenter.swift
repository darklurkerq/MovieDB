import Foundation

protocol DiscoverMoviesPresenterInput: AnyObject {
    var coordinator: ListByGenresCoordinatorProtocol? { get set }
    var view: DiscoverMoviesView? { get set }
    var genre: String! { get set }
    func loadMovies()
}

final class DiscoverMoviesPresenter {
    var coordinator: ListByGenresCoordinatorProtocol?
    weak var view: DiscoverMoviesView?
    @Injected
    var service: MovieServiceProtocol
    var genre: String!
    var movies = [String]()
    private var isLoading = false
    private var currentPage = 0
}

extension DiscoverMoviesPresenter: DiscoverMoviesPresenterInput {
    func loadMovies() {
        currentPage += 1
        isLoading = true
        service.loadMovies(genre: genre, page: currentPage) { result in
            switch result {
            case .success(let data):
                self.movies = data.compactMap({ $0.title })
                self.view?.newData(data: self.movies)
            case .failure(let err):
                print(err)
            }
            self.isLoading = false
        }
    }
}
