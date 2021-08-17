import Foundation

protocol GenresPresenterInput: AnyObject {
    var coordinator: ListByGenresCoordinatorProtocol? { get set }
    var view: GenresView? { get set }
    func loadGenres()
    func selectedGenre(_ genre: GenreViewModel)
}

final class GenresPresenter {
    var coordinator: ListByGenresCoordinatorProtocol?
    weak var view: GenresView?
    @Injected
    var interactor: ListByGenresInteractorInput
}

extension GenresPresenter: GenresPresenterInput {

    func loadGenres() {
        interactor.loadGenres { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.view?.configureView(genres: data)
            case .failure(let err):
                self.view?.handleError(error: err)
            }
        }
    }

    func selectedGenre(_ genre: GenreViewModel) {
        coordinator?.showDiscoverMoviesFor(genre: String(genre.identifier))
    }
}
