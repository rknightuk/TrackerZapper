//
//  DropDelegate.swift
//  TrackerZapper
//
//  Created by Robb Knight on 12/09/2021.
//

import Foundation
import SwiftUI

struct AppDropDelegate: DropDelegate
{

    func validateDrop(info: DropInfo) -> Bool
    {
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        print ("Drop Entered")
    }
    
    func performDrop(info: DropInfo) -> Bool
    {
        print ("performDrop")
        NSSound(named: "Submarine")?.play()
        
        print (info)
        print ("Has UniformTypeIdentifiers:", info.hasItemsConforming(to: uttypes))
        
        let items = info.itemProviders(for: uttypes)
        print ("Number of items:",items.count)
        print (items)

        for item in items
        {
            item.loadItem(forTypeIdentifier: (kUTTypeFileURL as String), options: nil) {item, error in
                guard let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) else { return }
                print(url)
                if !url.absoluteString.contains(".app") {
                    return
                }
                print(NSWorkspace.shared.frontmostApplication?.bundleURL)
                // have bundle URL, how do I get the app bundle ID based on this so
                // I can then match on NSWorkspace.shared.frontmostApplication?.bundleURL
            }
         }
        return true
    }
}
