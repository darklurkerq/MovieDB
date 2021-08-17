import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    let spinner = UIActivityIndicatorView(style: .medium).then {
        $0.color = .black
        $0.size(CGSize(width: 40, height: 40))
        $0.startAnimating()
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
        contentView.addSubview(spinner)
        spinner.centerInSuperview()
    }

}
