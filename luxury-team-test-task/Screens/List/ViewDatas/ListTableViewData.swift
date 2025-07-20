//
//  ListTableViewData.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

enum ListTableSection: Hashable {

    case main

}

enum ListTableItem: Hashable {

    case symbol(viewData: ListItemViewData)

}

struct ListItemViewData: Hashable {

    let imageURLString: String
    let symbol: String
    let isFavorite: Bool
    let name: String
    let price: String
    let change: String
    let changeColor: UIColor
    let cellBackgroundColor: UIColor

}
