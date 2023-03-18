//
//  AppDelegate.swift
//  OneTracker
//
//  Created by Max Kuznetsov on 16.03.2023.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    static var popover = NSPopover()
    var statusBar: StatusBarController?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        Self.popover.contentViewController = NSHostingController(rootView: PopoverView())
        
        statusBar = StatusBarController(Self.popover)
        
    }
    
}
