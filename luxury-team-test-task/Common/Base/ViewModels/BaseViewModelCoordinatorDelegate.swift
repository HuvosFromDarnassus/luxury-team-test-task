//
//  BaseViewModelCoordinatorDelegate.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

protocol BaseViewModelCoordinatorDelegate: AnyObject {

    func showAlert(with viewData: AlertViewData, from controller: UIViewController)
    func showAlertController(
        title: String?,
        items: [(title: String, action: (() -> Void))],
        from controller: UIViewController
    )
    func close(from controller: UIViewController, finish: Bool, _ completion: (() -> Void)?)

}

extension BaseViewModelCoordinatorDelegate {

    func close(from controller: UIViewController, finish: Bool = false, _ completion: (() -> Void)? = nil) {
        close(from: controller, finish: finish, completion)
    }

}
