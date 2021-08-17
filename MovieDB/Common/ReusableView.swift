import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        NSStringFromClass(self).components(separatedBy: ".").last ?? "ViewIdentifier"
    }
}

// Extend reusable views
extension UITableViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}
