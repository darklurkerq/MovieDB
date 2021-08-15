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
        registerGenreServices()
    }
}

extension Resolver {
    public static func registerGenreServices() {
        register { GenresPresenter() }.implements(GenresPresenterInput.self)
        register { GenresViewController() }.resolveProperties { _, vc in
            vc.presenter.view = vc
        }
    }
}
