import Foundation

protocol DiscoverMoviesPresenterInput: AnyObject {
    var coordinator: ListByGenresCoordinatorProtocol? { get set }
    var view: DiscoverMoviesView? { get set }
}

final class DiscoverMoviesPresenter {
    var coordinator: ListByGenresCoordinatorProtocol?
    weak var view: DiscoverMoviesView?
    @Injected
    var service: MovieServiceProtocol

}

extension DiscoverMoviesPresenter: DiscoverMoviesPresenterInput {}
