import Foundation

protocol GenresPresenterInput: AnyObject {
    var coordinator: ListByGenresCoordinatorProtocol? { get set }
    var view: GenresView? { get set }
    func loadGenres()
}

final class GenresPresenter {
    var coordinator: ListByGenresCoordinatorProtocol?
    weak var view: GenresView?
    @Injected
    var service: MovieServiceProtocol

}

extension GenresPresenter: GenresPresenterInput {
    func loadGenres() {
        service.loadGenres { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.view?.configureView(genres: data.compactMap({ $0.name }))
            case .failure(let err):
                print(err)
            }
        }
    }
}
