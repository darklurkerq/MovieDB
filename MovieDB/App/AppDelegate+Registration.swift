import Foundation
import UIKit

extension Resolver {
    enum Names {
        public static var rootViewController = "RootViewController"
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register(name: Resolver.Names.rootViewController ) { UINavigationController }.scope(application)
    }
}
