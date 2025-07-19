//
//  UIStackView+ArrangedSubviews.swift
//  AlarmPuzzles
//
//  Created by Daniel Tvorun on 03/10/2024.
//

import UIKit

extension UIStackView {

    func addArrangedSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview)
    }

}
