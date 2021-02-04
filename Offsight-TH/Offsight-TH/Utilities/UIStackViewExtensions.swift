//
//  UIStackViewExtensions.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import UIKit

extension UIStackView {

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
