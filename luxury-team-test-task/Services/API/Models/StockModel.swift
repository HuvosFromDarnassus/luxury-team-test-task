//
//  StockModel.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import Foundation

struct StockModel: Codable {

    let symbol, name: String
    let price, change, changePercent: Double
    let logo: String

}
