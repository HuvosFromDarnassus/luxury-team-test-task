//
//  CollectionRowViewData.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 20/07/2025.
//

import Foundation

enum CollectionViewSection: Hashable {

    case main

}

enum CollectionViewItem: Hashable {

    case item(viewData: CollectionItemViewData)

}

struct CollectionItemViewData: Hashable {

    let id: UUID = UUID()
    let title: String

}
