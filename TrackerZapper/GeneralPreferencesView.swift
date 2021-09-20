//
//  GeneralPreferencesView.swift
//  TrackerZapper
//
//  Created by Robb Knight on 11/09/2021.
//

import SwiftUI
import Preferences
import KeyboardShortcuts
import LaunchAtLogin

let uttypes = [String(kUTTypeFileURL)]

struct GeneralPreferencesView: View {
    private let contentWidth: Double = 300.0
    let dropDelegate = AppDropDelegate()

    var body: some View {
        Preferences.Container(contentWidth: contentWidth) {
            Preferences.Section(title: "Toggle Zapping:") {
                HStack(alignment: .firstTextBaseline) {
                    KeyboardShortcuts.Recorder(for: .toggleZapping)
                }
                LaunchAtLogin.Toggle()
                Text("HELLO")
                    .padding(20)
                    .onDrop(of: uttypes, delegate: dropDelegate as! DropDelegate)
            }
        }
    }
}

struct GeneralPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralPreferencesView()
    }
}

