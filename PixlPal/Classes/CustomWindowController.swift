//
//  CustomWindowController.swift
//  PixlPal
//
//  Created by Justin Chambers on 2023-04-01.
//

import Cocoa
import SwiftUI

class CustomWindowController<RootView: View>: NSWindowController {
    convenience init(rootView: RootView) {
        let hostingView = NSHostingView(rootView: rootView)
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.contentView = hostingView
        self.init(window: window)
    }
}
