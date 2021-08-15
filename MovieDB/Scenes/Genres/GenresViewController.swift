import UIKit

protocol GenresView: Toastable {
    var presenter: GenresPresenterInput { get set }
}

class GenresViewController: UIViewController {
    @Injected
    var presenter: GenresPresenterInput

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TMDB"
    }
}

extension GenresViewController: GenresView {}
