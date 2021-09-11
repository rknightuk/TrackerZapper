//
//  Constants.swift
//  TrackerZapper
//
//  Created by Robb Knight on 11/09/2021.
//

import Foundation
import Preferences
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let toggleZapping = Self("toggleZapping")
}

extension Preferences.PaneIdentifier {
    static let general = Self("general")
    static let advanced = Self("advanced")
}
