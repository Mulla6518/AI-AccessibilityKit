//
//  AutoVoiceOverLabelModifier.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public struct AutoVoiceOverLabelModifier: ViewModifier {
    @State private var suggested: String?
    @State private var inFlight = false

    private let labelGenerator: MLLabelGenerator?
    private let textDetector: TextDetector?
    private let snapshotter = Snapshotter()
    private let confidenceThreshold: Float

    public init(labelGenerator: MLLabelGenerator? = try? MLLabelGenerator(),
                textDetector: TextDetector? = TextDetector(),
                confidenceThreshold: Float = 0.45) {
        self.labelGenerator = labelGenerator
        self.textDetector = textDetector
        self.confidenceThreshold = confidenceThreshold
    }

    public func body(content: Content) -> some View {
        content
            .accessibilityLabel(suggested ?? "")
            .task {
                await generateLabelIfNeeded(content: content)
            }
    }

    private func generateLabelIfNeeded(content: Content) async {
        guard !inFlight else { return }
        inFlight = true
        defer { inFlight = false }

        // Snapshot the view; run OCR first, then ML.
        do {
            let img = try snapshotter.image(from: content)
            if let text = try await textDetector?.detectText(in: img), !text.isEmpty {
                suggested = text
                return
            }
            if let suggestion = try await labelGenerator?.suggestLabel(for: img),
               suggestion.confidence >= confidenceThreshold {
                suggested = suggestion.label
            }
        } catch {
            // No-op: leave label untouched
        }
    }
}

public extension View {
    /// Applies AI-based accessibility label if none provided.
    func autoVoiceOverLabel(
        labelGenerator: MLLabelGenerator? = try? MLLabelGenerator(),
        textDetector: TextDetector? = TextDetector(),
        confidenceThreshold: Float = 0.45
    ) -> some View {
        modifier(AutoVoiceOverLabelModifier(labelGenerator: labelGenerator,
                                            textDetector: textDetector,
                                            confidenceThreshold: confidenceThreshold))
    }
}
