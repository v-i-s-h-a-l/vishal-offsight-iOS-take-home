//
//  UIViewExtensions.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import UIKit

extension UIView {

    private func addConstraintsOnView(childView: UIView, parentView: UIView) {
        parentView.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: childView, attribute: .centerX, relatedBy: .equal, toItem: parentView, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: childView, attribute: .centerY, relatedBy: .equal, toItem: parentView, attribute: .centerY, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: childView, attribute: .leading, relatedBy: .equal, toItem: parentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: childView, attribute: .trailing, relatedBy: .equal, toItem: parentView, attribute: .trailing, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: childView, attribute: .height, relatedBy: .equal, toItem: parentView, attribute: .height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, xCenterConstraint, yCenterConstraint, heightConstraint])
    }

    func indicateLoading() {
        stopLoading()

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tag = Constant.loadingViewTag
        activityIndicator.center = center
        addConstraintsOnView(childView: activityIndicator, parentView: self)
        activityIndicator.startAnimating()

    }
    
    func stopLoading() {
        guard let overlay = viewWithTag(Constant.loadingViewTag) else { return }
        overlay.removeFromSuperview()
    }
}
