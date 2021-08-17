import UIKit

struct MovieViewModel {
    let image: String
    let title: String
}

class MovieCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.size(CGSize(width: 40, height: 40))
    }

    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .boldSystemFont(ofSize: 12)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        createLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        createLayout()
    }

    private func createLayout() {
        contentView.addSubview(imageView)
        imageView.topToSuperview()
        imageView.centerXToSuperview()

        contentView.addSubview(titleLabel)
        titleLabel.topToBottom(of: imageView, offset: 4)
        titleLabel.leftToSuperview(offset: 4)
        titleLabel.rightToSuperview(offset: -4)
    }

    func configure(with genre: MovieViewModel) {
        titleLabel.text = genre.title
    }
}
