//
//  ModeManagerView.swift
//  PixlPal
//
//  Created by Justin Chambers on 2023-03-23.
//

import SwiftUI

struct ModeManagerView: View {
    @ObservedObject var modeManager: ModeManager

    var body: some View {
        Menu("PixlPal") {
            Button("Color Picker Mode") {
                modeManager.currentMode = .colorPicker
            }
            .disabled(modeManager.currentMode == .colorPicker)

            Divider()

            Button("Preferences") {
                modeManager.currentMode = .preferences
            }
            .disabled(modeManager.currentMode == .preferences)

            Divider()

            Divider()

            Button("Quit") {
                NSApp.terminate(nil)
            }
        }
    }
}
