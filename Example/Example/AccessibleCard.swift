//
//  AccessibleCard.swift
//  Example
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI
import AIAccessibilityKit

struct AccessibleCard: View {
    let title: String
    let subtitle: String
    let symbolName: String

    var body: some View {
        VStack(spacing: 12) {
            // The image + label will be snapshotted by the toolkit and
            // AI-suggested label applied if none exists.
            Image(systemName: symbolName)
                .font(.system(size: 40))
                .foregroundStyle(.green)
                .autoVoiceOverLabel()           // AI label (OCR + model)
                .auditTouchTarget()             // ensures 44pt minimum

            Text(title)
                .dynamicFont(.title3)           // dynamic scaling helper
                .foregroundStyle(.primary)

            Text(subtitle)
                .dynamicFont(.body)
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Button("Continue") { }
                    .padding(.horizontal, 22)
                    .padding(.vertical, 12)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .autoVoiceOverLabel()       // AI label suggestion for the button if missing
                    .auditTouchTarget()

                Button {
                    //…
                } label: {
                    Label("More", systemImage: "ellipsis")
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                }
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .auditTouchTarget()
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        // Contrast badge (WCAG AA by default, toggle largeText for headings)
        .auditContrast(foreground: .primary, background: .white, isLargeText: false, level: .AA)
        .accessibilityHint("Rewards summary and action buttons.")
        .accessibilityElement(children: .combine)
    }
}

#Preview("AccessibleCard – Light") {
    AccessibleCard(title: "Eco Rewards",
                   subtitle: "Earn points for sustainable purchases and redeem perks.",
                   symbolName: "leaf.fill")
}

#Preview("AccessibleCard – Dark + A11y5") {
    AccessibleCard(title: "Eco Rewards",
                   subtitle: "Earn points for sustainable purchases and redeem perks.",
                   symbolName: "leaf.fill")
    .preferredColorScheme(.dark)
    .dynamicTypeSize(.accessibility5)
}
