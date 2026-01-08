//
//  AuditBadgeModifier.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public struct AuditBadge: ViewModifier {
    let fg: Color
    let bg: Color
    let isLargeText: Bool
    let level: WCAGLevel

    public func body(content: Content) -> some View {
        let result = ColorContrast.audit(foreground: fg, background: bg, level: level, isLargeText: isLargeText)

        return content.overlay(alignment: .topTrailing) {
            Text(String(format: "Contrast: %.2f %@", result.ratio,
                        result.passes ? "✅" : "⚠️"))
                .padding(6)
                .font(.caption2)
                .foregroundStyle(.white)
                .background(result.passes ? Color.green : Color.orange)
                .clipShape(Capsule())
                .accessibilityHidden(true)
        }
    }
}

public extension View {
    func auditContrast(foreground: Color, background: Color,
                       isLargeText: Bool = false, level: WCAGLevel = .AA) -> some View {
        modifier(AuditBadge(fg: foreground, bg: background, isLargeText: isLargeText, level: level))
    }
}
