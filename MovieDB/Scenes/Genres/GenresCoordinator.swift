import Foundation
import UIKit

protocol GenresCoordinatorProtocol {
    func showGenres()
}

final class GenresCoordinator {
    @Injected(name: Resolver.Names.rootViewController)
    private var rootNavigationController: UINavigationController

    private weak var appCoordinator: AppCoordinator?

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

extension GenresCoordinator: GenresCoordinatorProtocol {
    func showGenres() {
        let genresViewController: GenresViewController = Resolver.resolve()
        //genresViewController.presenter.coordinator = self
        rootNavigationController.viewControllers = [genresViewController]
    }
}
