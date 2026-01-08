//
//  ContentView.swift
//  Example
//
//  Created by Farooq Mulla on 1/8/26.
//


import SwiftUI
import AIAccessibilityKit

struct ContentView: View {
    @State var showAuditOverlay: Bool
    @State var showGrid: Bool
    @State private var prefersDark = false
    @State private var size: DynamicTypeSize = .medium

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // 1) An accessible hero card with AI-generated labels and audits
                    AccessibleCard(title: "Eco Rewards",
                                   subtitle: "Earn points for sustainable purchases and redeem perks.",
                                   symbolName: "leaf.fill")

                    // 2) A tile showing image labeling + touch target audit
                    ImageTile(symbolName: "suit.heart.fill",
                              title: "Favorites",
                              subtitle: "Quick access to saved items.")

                    // 3) A settings sheet for live audit toggles and preview controls
                    NavigationLink("Accessibility Settings") {
                        AccessibilitySettingsView(showAuditOverlay: $showAuditOverlay,
                                                  showGrid: $showGrid,
                                                  prefersDark: $prefersDark,
                                                  size: $size)
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityHint("Open audit and preview options.")
                }
                .padding()
            }
            .navigationTitle("AI Accessibility Demo")
            .preferredColorScheme(prefersDark ? .dark : .light)
            .dynamicTypeSize(size)
            .modifier(AccessibilityAuditOverlay(mode: showAuditOverlay ? .on : .off,
                                                showGrid: showGrid))
        }
    }
}

#Preview("Demo – Light (Default)") {
    ContentView(showAuditOverlay: true, showGrid: true)
}

#Preview("Demo – Dark (A11y3)") {
    ContentView(showAuditOverlay: true, showGrid: true)
        .preferredColorScheme(.dark)
        .dynamicTypeSize(.accessibility3)
}
