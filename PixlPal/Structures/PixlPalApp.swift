//
//  PixlPalApp.swift
//  PixlPal
//
//  Created by Justin Chambers on 2023-03-23.
//

import SwiftUI

@main
struct PixlPalApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}



class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItemManager: StatusItemManager?
    var modeManager = ModeManager()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItemManager = StatusItemManager(modeManager: modeManager)
    }
}
