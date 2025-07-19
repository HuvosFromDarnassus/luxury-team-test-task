//
//  UIView+Subviews.swift
//  AlarmPuzzles
//
//  Created by Daniel Tvorun on 03/10/2024.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }

}
