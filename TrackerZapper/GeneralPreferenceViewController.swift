//
//  GeneralPreferenceViewController.swift
//  TrackerZapper
//
//  Created by Robb Knight on 11/09/2021.
//

import Cocoa
import Preferences

@available(macOS 11.0, *)
final class GeneralPreferenceViewController: NSViewController, PreferencePane {
    let preferencePaneIdentifier = Preferences.PaneIdentifier.general
    let preferencePaneTitle = "General"
    let toolbarItemIcon = NSImage(systemSymbolName: "gearshape", accessibilityDescription: "General preferences")!

    override var nibName: NSNib.Name? { "GeneralPreferenceViewController" }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup stuff here
    }
}

