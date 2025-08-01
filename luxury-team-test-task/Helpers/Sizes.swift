//
//  Sizes.swift
//  AlarmPuzzles
//
//  Created by Daniel Tvorun on 03/10/2024.
//

import UIKit

struct Sizes {

    static let screenSize = UIScreen.main.bounds.size

    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height

    static var safeArea: UIEdgeInsets {
        let window = UIApplication.shared.keyWindow
        let safeArea = window?.safeAreaInsets ?? .zero
        return safeArea
    }

}
