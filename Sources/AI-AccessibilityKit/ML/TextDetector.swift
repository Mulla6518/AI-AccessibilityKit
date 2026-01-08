//
//  TextDetector.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import UIKit
import Vision

public actor TextDetector {
    public init() {}

    public func detectText(in image: UIImage) async throws -> String? {
        guard let cg = image.cgImage else { return nil }
        let request = VNRecognizeTextRequest()
        request.recognitionLevel = .accurate
        let handler = VNImageRequestHandler(cgImage: cg, orientation: .up)
        try handler.perform([request])
        let text = (request.results as? [VNRecognizedTextObservation])?
            .compactMap { $0.topCandidates(1).first?.string }
            .joined(separator: " ")
        return text?.isEmpty == true ? nil : text
    }
}
