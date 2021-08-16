import Foundation
import UIKit

protocol ListByGenresCoordinatorProtocol {
    func showGenres()
}

final class ListByGenresCoordinator {
    @Injected(name: Resolver.Names.rootViewController)
    private var rootNavigationController: UINavigationController

    private weak var appCoordinator: AppCoordinator?

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

extension ListByGenresCoordinator: ListByGenresCoordinatorProtocol {
    func showGenres() {
        let genresViewController: GenresViewController = Resolver.resolve()
        genresViewController.presenter.coordinator = self
        rootNavigationController.viewControllers = [genresViewController]
    }
}
