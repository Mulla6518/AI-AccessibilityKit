//
//  AccessibilityHelpers.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public enum AccessibilityHelpers {
    public static func largeText(_ font: Font) -> Bool {
        // Heuristic: titles/headlines treated as large text ( >= 18–24pt )
        // This is a preview-side hint; use WCAG large-text rule accordingly.
        return true // Keep simple for demo; wire to actual font metrics if needed.
    }
}
