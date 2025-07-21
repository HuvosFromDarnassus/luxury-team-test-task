//
//  RootViewModel.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

protocol RootViewModelProtocol: BaseViewModelProtocol {

    // MARK: Delegates

    var coordinatorDelegate: RootViewModelCoordinatorDelegate? { get set }

}

final class RootViewModel: BaseViewModel, RootViewModelProtocol {

    // MARK: Properties

    private let storageService: StorageService

    // MARK: Initializers

    init(storageService: StorageService = StorageServiceImplementation()) {
        self.storageService = storageService
    }

    // MARK: Delegates

    weak var coordinatorDelegate: RootViewModelCoordinatorDelegate?

    // MARK: Events

    override func start() {
        coordinatorDelegate?.startMainFlow()
        updateAppLaunchedStatus()
    }

    // MARK: Private

    private func updateAppLaunchedStatus() {
        storageService.saveInUserDefaults(value: true, with: .launchedBefore)
    }

}
