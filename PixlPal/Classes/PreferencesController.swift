//
//  PreferencesController.swift
//  PixelPal
//
//  Created by Justin Chambers on 2023-03-31.
//

import SwiftUI
import Cocoa

class PreferencesController: NSWindowController {
    init() {
        let contentView = PreferencesView()
        let preferencesWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        preferencesWindow.center()
        preferencesWindow.setFrameAutosaveName("Preferences")
        preferencesWindow.contentView = NSHostingView(rootView: contentView)
        super.init(window: preferencesWindow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
