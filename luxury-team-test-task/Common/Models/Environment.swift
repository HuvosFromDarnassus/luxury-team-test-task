//
//  Environment.swift
//  AlarmPuzzles
//
//  Created by Daniel Tvorun on 03/10/2024.
//

struct Environment {

    static func isProduction() -> Bool {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }

}
