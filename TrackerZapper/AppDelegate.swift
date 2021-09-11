//
//  AppDelegate.swift
//  TrackerZapper
//
//  Created by Robb Knight on 01/09/2021.
//

import Cocoa
import SwiftUI
import Preferences

extension NSNotification.Name {
    public static let NSPasteboardDidChange: NSNotification.Name = .init(rawValue: "pasteboardDidChangeNotification")
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var userDefaults = UserDefaults.standard
    var zappingEnabled = true
    var statusBar: NSStatusBar? = nil
    var statusItem: NSStatusItem? = nil
    
    var timer: Timer!
    let pasteboard: NSPasteboard = .general
    var lastChangeCount: Int = 0
    var previous: String? = nil

    @available(macOS 11.0, *)
    private lazy var preferencesWindowController = PreferencesWindowController(
        panes: [
            Preferences.Pane(
                identifier: .general,
                title: "General",
                toolbarIcon: NSImage(systemSymbolName: "bolt.circle.fill", accessibilityDescription: "General preferences")!
            ) {
                GeneralView()
            },
        ]
    )

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        userDefaults.register(
            defaults: [
                "zappingEnabled": true
            ]
        )
        userDefaults.set(UserDefaults.standard.bool(forKey: "zappingEnabled"), forKey: "zappingEnabled")
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (t) in
            if self.lastChangeCount != self.pasteboard.changeCount {
                self.lastChangeCount = self.pasteboard.changeCount
                NotificationCenter.default.post(name: .NSPasteboardDidChange, object: self.pasteboard)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(onPasteboardChanged), name: .NSPasteboardDidChange, object: nil)
        
        statusBar = NSStatusBar.init()
        statusItem = statusBar!.statusItem(withLength: 28.0)
        
        if let statusBarButton = statusItem!.button {
            if #available(macOS 11.0, *) {
                statusBarButton.image = NSImage(systemSymbolName: "bolt.circle.fill", accessibilityDescription: nil)
            } else {
                statusBarButton.image = #imageLiteral(resourceName: "StatusBarIcon")
                statusBarButton.image?.size = NSSize(width: 15.0, height: 15.0)
            }
            statusBarButton.image?.isTemplate = true
            statusBarButton.target = self
        }
        
        let statusBarMenu = NSMenu(title: "TrackerZapper Menu")
        statusItem?.menu = statusBarMenu

        statusBarMenu.addItem(
            withTitle: "Toggle Zapping",
            action: #selector(toggleEnabled(sender:)),
            keyEquivalent: "")
        
        statusBarMenu.addItem(
            withTitle: "About",
            action: #selector(showAbout(sender:)),
            keyEquivalent: "")
        
        statusBarMenu.addItem(
            withTitle: "Preferences",
            action: #selector(showPrefs(_:)),
            keyEquivalent: "")
        
        statusBarMenu.addItem(
            withTitle: "Quit",
            action: #selector(ExitNow(sender:)),
            keyEquivalent: "")
    }
    
    @objc func toggleEnabled(sender: AnyObject) {
        UserDefaults.standard.set(!zappingEnabled, forKey: "zappingEnabled")
        zappingEnabled = !zappingEnabled
        statusItem?.button?.appearsDisabled = !zappingEnabled
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        timer.invalidate()
    }
    
    @objc func showAbout(sender: AnyObject)
    {
        NSApplication.shared.orderFrontStandardAboutPanel(
            options: [
                NSApplication.AboutPanelOptionKey(rawValue: "Copyright"): "© 2021 Robb Knight"]
        )
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @IBAction
    func showPrefs(_ sender: NSMenuItem) {
        if #available(macOS 11.0, *) {
            preferencesWindowController.show()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc
    func onPasteboardChanged(_ notification: Notification) {
        guard let pb = notification.object as? NSPasteboard else { return }
        guard let items = pb.pasteboardItems else { return }
        guard (items.first?.data(forType: NSPasteboard.PasteboardType.fileURL) == nil) else { return }
        guard (items.first?.data(forType: NSPasteboard.PasteboardType.pdf) == nil) else { return }
        guard (items.first?.data(forType: NSPasteboard.PasteboardType.png) == nil) else { return }
        guard (items.first?.data(forType: NSPasteboard.PasteboardType.sound) == nil) else { return }
        guard (items.first?.data(forType: NSPasteboard.PasteboardType.tiff) == nil) else { return }
        guard let item = items.first?.string(forType: .string) else { return }
        
        if item.contains("<") { return } // assume it's HTML and don't run it
        
        if (item == previous)
        {
            previous = nil
            return
        }
        
        if (!zappingEnabled)
        {
            return
        }
    
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: item, options: [], range: NSRange(location: 0, length: item.utf16.count))

        // prefixes from various places including
        // https://github.com/newhouse/url-tracking-stripper/blob/master/assets/js/trackers.js
        let REMOVE = [
            "_bta_c",
            "_bta_tid",
            "_ga",
            "_hsenc",
            "_hsmi",
            "_ke",
            "_openstat",
            "dm_i",
            "ef_id",
            "epik",
            "fbclid",
            "gclid",
            "gclsrc",
            "gdffi",
            "gdfms",
            "gdftrk",
            "hsa_",
            "igshid",
            "matomo_",
            "mc_",
            "mkwid",
            "msclkid",
            "mtm_",
            "name",
            "ns_",
            "oly_anon_id",
            "oly_enc_id",
            "otc",
            "pcrid",
            "piwik_",
            "pk_",
            "rb_clickid",
            "redirect_log_mongo_id",
            "redirect_mongo_id",
            "ref",
            "s_kwcid",
            "sb_referer_host",
            "soc_src",
            "soc_trk",
            "spm",
            "sr_",
            "srcid",
            "stm_",
            "trk_",
            "utm_",
            "vero_",
        ]

        var formatted = item

        for match in matches {
            guard let range = Range(match.range, in: item) else { continue }
            let url = item[range]
            let urlParts = url.components(separatedBy: "?")
            if (urlParts.indices.contains(1))
            {
                var params = urlParts[1].components(separatedBy: "&")
                for r in REMOVE {
                    params = params.filter { !$0.starts(with: r)}
                }
                let joinedParams = params.joined(separator: "&")
                
                var formattedUrl = "\(urlParts[0])?\(joinedParams)"
                if (joinedParams == "")
                {
                    formattedUrl = urlParts[0]
                }
                formatted = formatted.replacingOccurrences(of: url, with: formattedUrl)
            }
        }

        previous = formatted

        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.setString(formatted, forType: .string)
    }
    
    @IBAction func ExitNow(sender: AnyObject) {
        NSApplication.shared.terminate(self)
    }
}

