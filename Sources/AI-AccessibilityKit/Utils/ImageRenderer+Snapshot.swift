//
//  ImageRenderer+Snapshot.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public enum SnapshotError: Error { case renderFailed }

public struct Snapshotter {
    public init() {}

    /// Renders a SwiftUI View to UIImage using ImageRenderer (iOS 16+).
    @MainActor public func image<V: View>(from view: V, scale: CGFloat = UIScreen.main.scale) throws -> UIImage {
        let renderer = ImageRenderer(content: view)
        renderer.scale = scale
        if let uiImage = renderer.uiImage {
            return uiImage
        } else {
            throw SnapshotError.renderFailed
        }
    }
}
