//
//  OptionItemViewData.swift
//  AlarmPuzzles
//
//  Created by Daniel Tvorun on 25/04/2025.
//

import UIKit

struct OptionItemViewData: Hashable {

    let title: String
    let value: String

    init(
        title: String,
        value: String
    ) {
        self.title = title
        self.value = value
    }

}
