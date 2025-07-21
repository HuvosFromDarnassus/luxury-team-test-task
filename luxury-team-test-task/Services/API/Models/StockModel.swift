//
//  StockModel.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import UIKit

struct StockModel: Codable, Hashable {

    // MARK: Properties

    let symbol: String
    let name: String
    let price: Double
    let change: Double
    let changePercent: Double
    let logo: String

    // MARK: Initializers

    init(
        symbol: String,
        name: String,
        price: Double,
        change: Double,
        changePercent: Double,
        logo: String
    ) {
        self.symbol = symbol
        self.name = name
        self.price = price
        self.change = change
        self.changePercent = changePercent
        self.logo = logo
    }

    init(from entity: FavoriteStock) {
        self.symbol = entity.symbol ?? ""
        self.name = entity.name ?? ""
        self.price = entity.price
        self.change = entity.change
        self.changePercent = entity.changePercent
        self.logo = entity.logo ?? ""
    }

    // MARK: Helpers

    func changeInfo() -> (text: String, color: UIColor) {
        let sign = change >= 0 ? "+" : "-"
        let absChange = abs(change)
        let absPercent = abs(changePercent)

        let formattedText = String(format: "%@$%.2f (%.2f%%)", sign, absChange, absPercent).replacingOccurrences(of: ".", with: ",")
        let color: UIColor = change >= 0 ? .systemGreen : .systemRed

        return (formattedText, color)
    }

}
