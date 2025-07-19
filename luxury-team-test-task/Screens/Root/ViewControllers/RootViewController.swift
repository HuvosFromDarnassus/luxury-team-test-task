//
//  RootViewController.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

import SnapKit

final class RootViewController: UIViewController {

    // MARK: Properties

    var viewModel: RootViewModelProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.start()
    }

    // MARK: Private

    private func setup() {}

}
