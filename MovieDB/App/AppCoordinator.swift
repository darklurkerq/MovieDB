import Foundation
import UIKit

final class AppCoordinator {

    private var window: UIWindow

    init?(window: UIWindow?) {
        guard let window = window else { return nil }
        self.window = window

        let rootViewController: UINavigationController = Resolver.resolve(name: Resolver.Names.rootViewController)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func start() {
        ListByGenresCoordinator(appCoordinator: self).showGenres()
    }
}
