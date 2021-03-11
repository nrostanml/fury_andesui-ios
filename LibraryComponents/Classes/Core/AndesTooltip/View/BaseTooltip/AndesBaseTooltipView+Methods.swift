//
//  AndesBaseTooltipView+Methods.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 18-02-21.
//

import Foundation

extension AndesBaseTooltipView {

    func show(target targetView: UIView, withinSuperview superview: UIView, position: AndesTooltipPosition) {

        self.bubblePosition = position
        presentingView = targetView
        arrange(withinSuperview: superview)
        superview.addSubview(self)
        self.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

        transform = CGAffineTransform(translationX: 0, y: animationTransform)
        alpha = 0

        UIView.animate(withDuration: self.animationDuration, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.alpha = 1
            self?.transform = .identity
        })
    }

    func dismiss() {
        UIView.animate(withDuration: self.animationDuration, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.frame.origin.y += self?.animationTransform ?? 0
            self?.alpha = 0
        }) { [weak self] _ in
            self?.delegate?.onDismissed()
            self?.removeFromSuperview()
        }
    }
}
