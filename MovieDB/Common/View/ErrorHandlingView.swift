import Foundation
import UIKit

protocol ErrorHandlingView: AnyObject {
    func handleError(error: Error)
}

extension ErrorHandlingView where Self: UIViewController {
    func handleError(error: Error) {
        // Some error handling code
    }
}
