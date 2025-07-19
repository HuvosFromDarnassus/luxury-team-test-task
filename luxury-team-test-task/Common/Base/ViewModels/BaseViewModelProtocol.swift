//
//  BaseViewModelProtocol.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

protocol BaseViewModelProtocol: AnyObject {

    // MARK: Events

    func start()
    func finish(from viewController: UIViewController)

}
