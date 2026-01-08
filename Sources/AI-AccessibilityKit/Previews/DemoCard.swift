//
//  DemoCard.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public struct DemoCard: View {
    public init() {}

    public var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 36))
                .foregroundStyle(.green)

            Text("Eco Rewards")
                .dynamicFont(.title3)
                .foregroundStyle(.primary)

            Text("Earn points for sustainable purchases and redeem them for perks.")
                .dynamicFont(.body)
                .foregroundStyle(.secondary)

            Button("Continue") {}
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .autoVoiceOverLabel()              // AI label (image snapshot + OCR/ML)
                .auditTouchTarget()                // 44pt minimum hint
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .auditContrast(foreground: .primary, background: .white, isLargeText: false, level: .AA)
        .accessibilityAuditOverlay(showGrid: true)
    }
}
