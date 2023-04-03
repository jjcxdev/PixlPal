//
//  StatusItemManager.swift
//  PixlPal
//
//  Created by Justin Chambers on 2023-03-27.
//

import SwiftUI
import Cocoa

enum ColorFormat: String {
    case hsl
    case rgb
    case hex
}

class StatusItemManager: NSObject, NSMenuDelegate {
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private let modeManager: ModeManager
    private var preferencesController: PreferencesController?
    
    init(modeManager: ModeManager) {
        self.modeManager = modeManager
        super.init()
        setupMenu()
    }
    
    
    private func setupMenu() {
        let menu = NSMenu()
        let colorPickerMenuItem = NSMenuItem(title: "Color Picker Mode", action: #selector(setColorPickerMode), keyEquivalent: "c")
        
        let preferencesMenuItem = NSMenuItem(title: "Preferences...", action: #selector(showPreferences), keyEquivalent: ",")
        
        
        colorPickerMenuItem.target = self
        preferencesMenuItem.target = self
        
        menu.addItem(colorPickerMenuItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(preferencesMenuItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit PixelPal", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        menu.delegate = self
        statusItem.menu = menu
        statusItem.button?.title = "PixelPal"
    }
    
    @objc private func showPreferences() {
        preferencesController = PreferencesController()
        preferencesController?.showWindow(nil)
    }
    
    @objc private func setColorPickerMode() {
        modeManager.currentMode = .colorPicker
        NSColorSampler().show { color in
            if let color = color {
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                let colorFormat = ColorFormat(rawValue: UserDefaults.standard.string(forKey: "colorFormat") ?? "hex") ?? .hex
                switch colorFormat {
                case .hsl:
                    pasteboard.setString(color.hslString, forType: .string)
                case .rgb:
                    pasteboard.setString(color.rgbString, forType: .string)
                case .hex:
                    pasteboard.setString(color.hexString, forType: .string)
                }
            }
        }
    }
}
