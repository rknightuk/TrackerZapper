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

struct GeneralPreferencesView: View {
    private let contentWidth: Double = 300.0

    var body: some View {
        Preferences.Container(contentWidth: contentWidth) {
            Preferences.Section(title: "Toggle Zapping:") {
                HStack(alignment: .firstTextBaseline) {
                    KeyboardShortcuts.Recorder(for: .toggleZapping)
                }
                LaunchAtLogin.Toggle()
            }
        }
    }
}

struct GeneralPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralPreferencesView()
    }
}

