//
//  NSColorExtension.swift
//  PixlPal
//
//  Created by Justin Chambers on 2023-03-27.
//

import AppKit

extension NSColor {
    var hexString: String {
        let red = Int(round(self.redComponent * 255.0))
        let green = Int(round(self.greenComponent * 255.0))
        let blue = Int(round(self.blueComponent * 255.0))
        return String(format: "#%02X%02X%02X", red, green, blue)
    }

    var rgbString: String {
        let red = Int(round(self.redComponent * 255.0))
        let green = Int(round(self.greenComponent * 255.0))
        let blue = Int(round(self.blueComponent * 255.0))
        return String(format: "%d, %d, %d", red, green, blue)
    }

    var hslString: String {
        let hsl = self.hsl
        return String(format: "%.2f, %.2f%%, %.2f%%", hsl.hue, hsl.saturation * 100, hsl.lightness * 100)
    }

    var hsl: (hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        let r = self.redComponent
        let g = self.greenComponent
        let b = self.blueComponent

        let maxVal = max(r, max(g, b))
        let minVal = min(r, min(g, b))

        let delta = maxVal - minVal

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        let lightness = (maxVal + minVal) / 2

        if delta != 0 {
            saturation = lightness < 0.5 ? delta / (maxVal + minVal) : delta / (2 - maxVal - minVal)

            if maxVal == r {
                hue = (g - b) / delta + (g < b ? 6 : 0)
            } else if maxVal == g {
                hue = (b - r) / delta + 2
            } else {
                hue = (r - g) / delta + 4
            }

            hue /= 6
        }

        return (hue: hue, saturation: saturation, lightness: lightness)
    }
}
