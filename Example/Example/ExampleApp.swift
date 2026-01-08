//
//  ExampleApp.swift
//  Example
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

@main
struct ExampleApp: App {
    @State private var showAuditOverlay = true
    @State private var showGrid = true

    var body: some Scene {
        WindowGroup {
            ContentView(showAuditOverlay: showAuditOverlay, showGrid: showGrid)
                .environment(\.colorScheme, .light)
        }
        .commands {
            CommandMenu("Accessibility Audits") {
                Toggle("Show Audit Overlay", isOn: $showAuditOverlay)
                Toggle("Show 44pt Grid", isOn: $showGrid)
            }
        }
    }
}
