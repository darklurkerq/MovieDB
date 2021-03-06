import Foundation
import UIKit

extension Resolver {
    enum Names {
        public static var rootViewController = "RootViewController"
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register(name: Resolver.Names.rootViewController ) { UINavigationController() }.scope(application)
        register { MovieService() }.implements(MovieServiceProtocol.self).scope(application)
        registerGenreServices()
    }
}

extension Resolver {
    public static func registerGenreServices() {
        register { ListByGenresInteractor() }.implements(ListByGenresInteractorInput.self)

        register { GenresPresenter() }.implements(GenresPresenterInput.self)
        register { GenresViewController() }.resolveProperties { _, controller in
            controller.presenter.view = controller
        }

        register { DiscoverMoviesPresenter() }.implements(DiscoverMoviesPresenterInput.self)
        register { DiscoverMoviesViewController() }.resolveProperties { _, controller in
            controller.presenter.view = controller
        }
    }
}
