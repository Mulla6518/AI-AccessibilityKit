//
//  AccessibilitySettingsView.swift
//  Example
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI
import AIAccessibilityKit

struct AccessibilitySettingsView: View {
    @Binding var showAuditOverlay: Bool
    @Binding var showGrid: Bool
    @Binding var prefersDark: Bool
    @Binding var size: DynamicTypeSize

    var body: some View {
        Form {
            Section("Audits") {
                Toggle("Show Audit Overlay", isOn: $showAuditOverlay)
                Toggle("Show 44pt Grid", isOn: $showGrid)
            }

            Section("Preview") {
                Toggle("Dark Mode", isOn: $prefersDark)

                Picker("Dynamic Type", selection: $size) {
                    Text("Small").tag(DynamicTypeSize.xSmall)
                    Text("Medium").tag(DynamicTypeSize.medium)
                    Text("Large").tag(DynamicTypeSize.xLarge)
                    Text("A11y 3").tag(DynamicTypeSize.accessibility3)
                    Text("A11y 5").tag(DynamicTypeSize.accessibility5)
                }
            }

            Section("About") {
                Text("This demo uses AIAccessibilityKit to:\n• auto-generate VoiceOver labels via Core ML + Vision\n• audit WCAG contrast in real-time\n• enforce touch-target size\n• visualize a 44pt grid overlay in previews/runtime")
                    .dynamicFont(.footnote)
            }
        }
        .navigationTitle("Accessibility Settings")
    }
}

#Preview("Settings") {
    AccessibilitySettingsView(
        showAuditOverlay: .constant(true),
        showGrid: .constant(true),
        prefersDark: .constant(false),
        size: .constant(.medium)
    )
}

