//
//  ColorContrast.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public enum WCAGLevel { case AA, AAA }

public struct ContrastResult: Sendable {
    public let ratio: Double
    public let passes: Bool
}

public struct ColorContrast {
    // WCAG relative luminance and contrast ratio calculations
    public static func contrastRatio(foreground: Color, background: Color) -> Double {
        let fgL = luminance(from: foreground)
        let bgL = luminance(from: background)
        return (max(fgL, bgL) + 0.05) / (min(fgL, bgL) + 0.05)
    }

    /// Required ratio for normal text: 4.5 (AA), 7.0 (AAA)
    public static func passes(_ ratio: Double, level: WCAGLevel, isLargeText: Bool) -> Bool {
        switch (level, isLargeText) {
        case (.AA, false): return ratio >= 4.5
        case (.AA, true):  return ratio >= 3.0
        case (.AAA, false): return ratio >= 7.0
        case (.AAA, true):  return ratio >= 4.5
        }
    }

    public static func audit(foreground: Color, background: Color,
                             level: WCAGLevel = .AA, isLargeText: Bool = false) -> ContrastResult {
        let r = contrastRatio(foreground: foreground, background: background)
        return ContrastResult(ratio: r, passes: passes(r, level: level, isLargeText: isLargeText))
    }

    // Convert SwiftUI Color to sRGB components & luminance
    private static func luminance(from color: Color) -> Double {
        let ui = UIColor(color)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        ui.getRed(&r, green: &g, blue: &b, alpha: &a)

        func comp(_ c: CGFloat) -> Double {
            let v = Double(c)
            return v <= 0.03928 ? v / 12.92 : pow((v + 0.055) / 1.055, 2.4)
        }
        return 0.2126 * comp(r) + 0.7152 * comp(g) + 0.0722 * comp(b)
    }
}
