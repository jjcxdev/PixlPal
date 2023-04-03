//
//  PreferencesView.swift
//  PixlPal
//
//  Created by Justin Chambers on 2023-03-23.
//

import SwiftUI

struct PreferencesView: View {
    @AppStorage("colorFormat") private var colorFormat: ColorFormat.RawValue = ColorFormat.hex.rawValue

    private enum ColorFormat: String, CaseIterable {
        case hsl, rgb, hex

        var description: String {
            switch self {
            case .hsl: return "HSL"
            case .rgb: return "RGB"
            case .hex: return "HEX"
            }
        }
    }

    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 10) {
                Text("Select your color format")
                    .font(.headline)
                Picker("Color Format", selection: $colorFormat) {
                    ForEach(ColorFormat.allCases, id: \.self) { format in
                        Text(format.description).tag(format.rawValue)
                    }
                }
                .pickerStyle(RadioGroupPickerStyle())
            }
        }
        .padding()
        .frame(width: 300)
    }
}
