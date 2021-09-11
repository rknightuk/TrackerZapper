//
//  AdvancedPreferenceViewController.swift
//  TrackerZapper
//
//  Created by Robb Knight on 11/09/2021.
//

import Cocoa
import Preferences

@available(macOS 11.0, *)
final class AdvancedPreferenceViewController: NSViewController, PreferencePane {
    let preferencePaneIdentifier = Preferences.PaneIdentifier.advanced
    let preferencePaneTitle = "Advanced"
    let toolbarItemIcon = NSImage(systemSymbolName: "gearshape.2", accessibilityDescription: "Advanced preferences")!

    override var nibName: NSNib.Name? { "AdvancedPreferenceViewController" }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup stuff here
    }
}
