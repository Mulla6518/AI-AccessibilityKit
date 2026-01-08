//
//  TouchTargetAudit.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public struct TouchTargetAudit: ViewModifier {
    public let minSize: CGSize

    public init(minSize: CGSize = CGSize(width: 44, height: 44)) {
        self.minSize = minSize
    }

    public func body(content: Content) -> some View {
        content.overlay {
            GeometryReader { geo in
                let size = geo.size
                if size.width < minSize.width || size.height < minSize.height {
                    ZStack {
                        Color.clear
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                            .accessibilityHidden(true)
                    }
                }
            }
        }
    }
}

public extension View {
    func auditTouchTarget(minSize: CGSize = CGSize(width: 44, height: 44)) -> some View {
        modifier(TouchTargetAudit(minSize: minSize))
    }
}
