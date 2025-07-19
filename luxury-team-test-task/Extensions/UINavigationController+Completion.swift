//
//  UINavigationController+Completion.swift
//  AlarmPuzzles
//
//  Created by Daniel Tvorun on 03/10/2024.
//

import UIKit

extension UINavigationController {

    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)
        if animated, let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        }
        else {
            completion()
        }
    }

}
