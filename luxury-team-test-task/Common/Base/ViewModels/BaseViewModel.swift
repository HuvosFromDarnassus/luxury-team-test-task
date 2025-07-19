//
//  BaseViewModel.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

class BaseViewModel: BaseViewModelProtocol {

    // MARK: Events

    func start() {}

    func finish(from viewController: UIViewController) {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func showErrorAlert(
        _ message: String,
        in viewController: UIViewController,
        coordinatorDelegate: BaseViewModelCoordinatorDelegate?
    ) {
        let alertViewData = AlertViewData(
            title: Strings.Common.Alert.Error.title,
            text: message,
            actionStyle: .default,
            closeButtonTitle: Strings.Common.Button.Close.title
        )
        coordinatorDelegate?.showAlert(with: alertViewData, from: viewController)
    }

}
