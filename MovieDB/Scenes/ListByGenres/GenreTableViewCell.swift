import UIKit
import TinyConstraints

class GenreTableViewCell: UITableViewCell {

    private let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: 16)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createLayout() {
        addSubview(titleLabel)
        titleLabel.edgesToSuperview(insets: .init(top: 12, left: 8, bottom: 12, right: 8))
    }

    func configure(with title: GenreName) {
        titleLabel.text = title
    }
}
