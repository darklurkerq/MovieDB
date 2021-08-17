import UIKit

protocol DiscoverMoviesView: ErrorHandlingView {
    var presenter: DiscoverMoviesPresenterInput { get set }
    func newData(data: [String])
}

class DiscoverMoviesViewController: UIViewController {
    enum CollectionSection: Int {
        case normal
        case loading
    }

    @Injected
    var presenter: DiscoverMoviesPresenterInput
    var datasource = [String]()
    private let pageLimit = 1000

    private var gridLayout: UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            // Show 2 per row on phones, 4 per row on tablets
            let sizeClass: CGFloat = self.view.traitCollection.horizontalSizeClass == .compact ? 2.0 : 4.0
            // Use row calculation on first section, use full width otherwise
            let numberOfColumns = sectionIndex == 0 ? CGFloat(1.0) / sizeClass : 1.0
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(numberOfColumns), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultReuseIdentifier)
        collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: LoadingCollectionViewCell.defaultReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray2
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        presenter.loadMovies()
        createLayout()
    }

    func createLayout() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
}

extension DiscoverMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = CollectionSection(rawValue: section) else { return 0 }
        switch section {
        case .normal:
            return datasource.count
        case .loading:
            return datasource.count <= pageLimit ? 1 : 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = CollectionSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .normal:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.defaultReuseIdentifier,
                                                                for: indexPath) as? MovieCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: MovieViewModel(image: "", title: datasource[indexPath.row]))
            return cell
        case .loading:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.defaultReuseIdentifier,
                                                                for: indexPath) as? LoadingCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let section = CollectionSection(rawValue: indexPath.section) else { return }
        guard !datasource.isEmpty else { return }

        if section == .loading {
            presenter.loadMovies()
        }
    }

}

extension DiscoverMoviesViewController: DiscoverMoviesView {
    func newData(data: [String]) {
        self.datasource.append(contentsOf: data)
        self.collectionView.insertItems(at: calculateIndexPathsToReload(from: data))
    }

    private func calculateIndexPathsToReload(from newMovies: [String]) -> [IndexPath] {
        let startIndex = datasource.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
    }
}
