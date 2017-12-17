import UIKit

extension UIView {

    func pinAllEdges() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }

    func constrain(size: CGSize) {
        constrain(width: size.width)
        constrain(height: size.height)
    }

    @discardableResult func constrain(height: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    @discardableResult func constrain(width: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    func pinTop(constant: CGFloat) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: constant)
            ])
    }

    func pinTopMargin(constant: CGFloat) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .topMargin, multiplier: 1, constant: constant)
            ])
    }

    func pinLeft(constant: CGFloat) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leadingMargin, multiplier: 1, constant: constant)
            ])
    }

    func pinRight(constant: CGFloat) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailingMargin, multiplier: 1, constant: constant)
            ])
    }

    func centerY() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0)
            ])
    }

    func centerX() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0)
            ])
    }

    @discardableResult func pinBottom(constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottomMargin, multiplier: 1, constant: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    func pinBottom(constant: CGFloat, to view: UIView) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: constant)
            ])
    }

    typealias Constraint = (_ child: UIView, _ parent: UIView) -> NSLayoutConstraint

    func equal<L, Axis>(_ to: KeyPath<UIView, L>) -> Constraint where L: NSLayoutAnchor<Axis> {
        return { view, parent in
            view[keyPath: to].constraint(equalTo: parent[keyPath: to])
        }
    }

    func equal<L>(_ keyPath: KeyPath<UIView, L>, to constant: CGFloat) -> Constraint where L: NSLayoutDimension {
        return { view, parent in
            view[keyPath: keyPath].constraint(equalToConstant: constant)
        }
    }

    func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>) -> Constraint where L: NSLayoutAnchor<Axis> {
        return { view, parent in
            view[keyPath: from].constraint(equalTo: parent[keyPath: to])
        }
    }
}

