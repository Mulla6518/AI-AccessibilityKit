//
//  AccessibilityPreviewGallery.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public struct AccessibilityPreviewGallery: View {
    public init() {}

    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                DemoCard()
                DemoCard()
                    .preferredColorScheme(.dark)
            }
            .padding()
        }
    }
}

#Preview("Accessibility Audit – Light") {
    AccessibilityPreviewGallery()
        .dynamicTypeSize(.xLarge) // Live audit with larger type
}

#Preview("Accessibility Audit – Dark") {
    AccessibilityPreviewGallery()
        .preferredColorScheme(.dark)
        .dynamicTypeSize(.accessibility3)
}
