import UIKit

typealias GenreName = String

protocol GenresView: Toastable {
    var presenter: GenresPresenterInput { get set }
    func configureView(genres: [GenreName])
}

class GenresViewController: UIViewController {
    private static let cellID = "genreCell"

    @Injected
    var presenter: GenresPresenterInput
    private var datasource = [GenreName]()

    private let tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tableFooterView = UIView(frame: .zero)
        $0.backgroundColor = .clear
        $0.separatorStyle = .singleLine
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.rowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
        $0.register(GenreTableViewCell.self, forCellReuseIdentifier: cellID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TMDB"

        tableView.dataSource = self
        tableView.delegate = self

        view.backgroundColor = .lightGray
        createLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.loadGenres()
    }

    func createLayout() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
}

extension GenresViewController: GenresView {
    func configureView(genres: [GenreName]) {
        datasource = genres
        tableView.reloadData()
    }
}

extension GenresViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenresViewController.cellID) as? GenreTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: GenresViewController.cellID)
        }
        cell.configure(with: datasource[indexPath.row])

        return cell
    }

}
