import UIKit

extension UIViewController {
    func present(controller: UIViewController, from button: UIButton) {
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .popover
        nav.popoverPresentationController?.delegate = self

        nav.popoverPresentationController?.sourceView = button
        nav.popoverPresentationController?.sourceRect = button.bounds
    }

}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
