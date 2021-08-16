import UIKit

protocol DiscoverMoviesView: Toastable {
    var presenter: DiscoverMoviesPresenterInput { get set }
}

class DiscoverMoviesViewController: UIViewController {
    @Injected
    var presenter: DiscoverMoviesPresenterInput

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
}

extension DiscoverMoviesViewController: DiscoverMoviesView {}
