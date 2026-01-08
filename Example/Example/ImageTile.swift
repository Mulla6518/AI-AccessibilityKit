//
//  ImageTile.swift
//  Example
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI
import AIAccessibilityKit

struct ImageTile: View {
    let symbolName: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: symbolName)
                .font(.system(size: 28))
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .autoVoiceOverLabel()   // will propose “heart” or similar via the model
                .auditTouchTarget()

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .dynamicFont(.headline)
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .dynamicFont(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                // open favorites
            } label: {
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .padding(10)
            }
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .auditTouchTarget()
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .auditContrast(foreground: .primary, background: .white, isLargeText: false, level: .AA)
        .accessibilityHint("Quick link to Favorites.")
    }
}

#Preview("ImageTile") {
    ImageTile(symbolName: "suit.heart.fill",
              title: "Favorites",
              subtitle: "Quick access to saved items.")
}

