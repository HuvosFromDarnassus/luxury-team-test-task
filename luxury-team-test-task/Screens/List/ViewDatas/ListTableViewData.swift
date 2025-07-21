//
//  ListTableViewData.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

enum ListTableSection: Hashable {

    case main
    case popular
    case searched

}

enum ListTableItem: Hashable {

    case symbol(viewData: ListItemViewData)
    case cellectionRow(items: CollectionRowViewData)
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

struct CollectionRowViewData: Hashable {

    let collectionItems: [String]
    let section: ListTableSection // popular, searched

}
