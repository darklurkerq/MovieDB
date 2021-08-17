import UIKit

protocol GenresView: ErrorHandlingView {
    var presenter: GenresPresenterInput { get set }
    func configureView(genres: [GenreViewModel])
}

class GenresViewController: UIViewController {
    @Injected
    var presenter: GenresPresenterInput
    private var datasource = [GenreViewModel]()

    private lazy var  tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tableFooterView = UIView(frame: .zero)
        $0.backgroundColor = .clear
        $0.separatorStyle = .singleLine
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.rowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(GenreTableViewCell.self, forCellReuseIdentifier: GenreTableViewCell.defaultReuseIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TMDB"

        view.backgroundColor = .systemBackground
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

extension GenresViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.defaultReuseIdentifier) as? GenreTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: GenreTableViewCell.defaultReuseIdentifier)
        }
        cell.configure(with: datasource[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectedGenre(datasource[indexPath.row])
    }
}

extension GenresViewController: GenresView {
    func configureView(genres: [GenreViewModel]) {
        datasource = genres
        tableView.reloadData()
    }
}
