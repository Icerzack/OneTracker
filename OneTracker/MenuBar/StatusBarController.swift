//
//  StatusBarController.swift
//  OneTracker
//
//  Created by Max Kuznetsov on 16.03.2023.
//

import AppKit

class StatusBarController {
    private var statusBar: NSStatusBar
    private(set) var statusItem: NSStatusItem
    private(set) var popover: NSPopover
    
    init(_ popover: NSPopover) {
        self.popover = popover
        self.popover.behavior = .transient

        statusBar = .init()
        statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("radar-white"))
            button.action = #selector(showApp)
            button.target = self
        }
    }
    
    @objc func showApp(sender: AnyObject) {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .maxY)
        }
    }
    

}
