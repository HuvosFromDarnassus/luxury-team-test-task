//
//  BaseCollectionViewCell.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

import Reusable

class BaseCollectionViewCell: UICollectionViewCell, Reusable {

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        initilization()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initilization()
    }

    func initilization() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

}
