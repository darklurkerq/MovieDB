import Foundation

protocol GenresPresenterInput: AnyObject {
    var coordinator: GenresCoordinatorProtocol? { get set }
    var view: GenresView? { get set }
}

final class GenresPresenter {
    var coordinator: GenresCoordinatorProtocol?
    weak var view: GenresView?
}

extension GenresPresenter: GenresPresenterInput {
}
