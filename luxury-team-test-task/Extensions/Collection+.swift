//
//  Collection+.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 20/07/2025.
//

import Foundation

extension Collection {

    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}
