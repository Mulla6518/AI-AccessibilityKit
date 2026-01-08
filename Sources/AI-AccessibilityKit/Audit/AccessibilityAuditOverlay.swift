//
//  AccessibilityAuditOverlay.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public struct AccessibilityAuditOverlay: ViewModifier {
    public enum Mode { case on, off }

    private let mode: Mode
    private let showGrid: Bool

    public init(mode: Mode = .on, showGrid: Bool = false) {
        self.mode = mode
        self.showGrid = showGrid
    }

    public func body(content: Content) -> some View {
        if mode == .on {
            content.overlay {
                ZStack {
                    if showGrid {
                        GridOverlay().accessibilityHidden(true)
                    }
                }
            }
        } else {
            content
        }
    }
}

struct GridOverlay: View {
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let step: CGFloat = 44
                for x in stride(from: 0, to: geo.size.width, by: step) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: geo.size.height))
                }
                for y in stride(from: 0, to: geo.size.height, by: step) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geo.size.width, y: y))
                }
            }
            .stroke(Color.gray.opacity(0.25), lineWidth: 0.5)
        }
    }
}

public extension View {
    func accessibilityAuditOverlay(mode: AccessibilityAuditOverlay.Mode = .on,
                                   showGrid: Bool = false) -> some View {
        modifier(AccessibilityAuditOverlay(mode: mode, showGrid: showGrid))
    }
}
