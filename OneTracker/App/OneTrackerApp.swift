//
//  OneTrackerApp.swift
//  OneTracker
//
//  Created by Max Kuznetsov on 15.03.2023.
//

import SwiftUI

@main
struct OneTrackerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            PopoverView()
        }
    }
}
