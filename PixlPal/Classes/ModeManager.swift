//
//  ModeManager.swift
//  PixlPal
//
//  Created by Justin Chambers on 2023-03-27.
//

import SwiftUI

class ModeManager: ObservableObject {
    @Published var currentMode: Mode = .idle

    enum Mode {
        case idle
        case colorPicker
        case preferences
    }
}
