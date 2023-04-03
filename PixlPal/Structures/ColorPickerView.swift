//
//  ColorPicker.swift
//  PixlPal
//
//  Created by Justin Chambers on 2023-03-23.
//

import SwiftUI
import AppKit

struct ColorPickerView: View {
    @AppStorage("colorFormat") private var colorFormat: ColorFormat.RawValue = ColorFormat.hex.rawValue
    @State private var color: NSColor = .clear
    @State private var mouseLocation: CGPoint = .zero


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

    private func colorString(from color: NSColor) -> String {
        guard let format = ColorFormat(rawValue: colorFormat) else { return color.hexString }

        switch format {
        case .hsl:
            return "HSL: \(color.hslString)"
        case .rgb:
            return "RGB: \(color.rgbString)"
        case .hex:
            return "HEX: \(color.hexString)"
        }
    }

    func saveColorToClipboard(color: NSColor) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(colorString(from: color), forType: .string)
    }

    func getColorAtPoint(_ point: CGPoint) -> NSColor {
        let pixelHeight = 1
        let pixelWidth = 1
        let screenRect = CGRect(x: point.x - CGFloat(pixelWidth) / 2, y: NSScreen.main!.frame.size.height - point.y - CGFloat(pixelHeight) / 2, width: CGFloat(pixelWidth), height: CGFloat(pixelHeight))
        
        guard let cgImage = CGWindowListCreateImage(screenRect, .optionOnScreenOnly, kCGNullWindowID, .bestResolution) else {
            return NSColor.clear
        }
        
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        return NSColor(calibratedRed: CGFloat(bitmapRep.colorAt(x: 0, y: 0)!.redComponent),
                       green: CGFloat(bitmapRep.colorAt(x: 0, y: 0)!.greenComponent),
                       blue: CGFloat(bitmapRep.colorAt(x: 0, y: 0)!.blueComponent),
                       alpha: CGFloat(bitmapRep.colorAt(x: 0, y: 0)!.alphaComponent))
    }

    var body: some View {
        VStack {
            Text("Color: \(colorString(from: color))")
                .background(Color.white.opacity(0.5))
                .position(x: mouseLocation.x + 40, y: mouseLocation.y)
        }
        .onAppear {
            NSEvent.addLocalMonitorForEvents(matching: .leftMouseDown) { event in
                saveColorToClipboard(color: color)
                return event
            }
            NSEvent.addLocalMonitorForEvents(matching: .mouseMoved) { event in
                mouseLocation = event.locationInWindow
                color = getColorAtPoint(mouseLocation)
                return event
            }
        }
    }
}
