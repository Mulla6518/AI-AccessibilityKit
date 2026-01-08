//
//  MLLabelGenerator.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI
import Vision
import CoreML
import Foundation

public struct MLLabelSuggestion: Sendable {
    public let label: String
    public let confidence: Float
}

public enum MLLabelGeneratorError: Error {
    case modelNotFound, imageConversionFailed, requestFailed
}

public actor MLLabelGenerator {
    private var vnModel: VNCoreMLModel?

    public init(modelName: String = "ImageClassifier") throws {
        // Load Core ML model bundled with the package or host app.
        guard let url = Bundle.module.url(forResource: modelName, withExtension: "mlmodelc")
            ?? Bundle.module.url(forResource: modelName, withExtension: "mlmodel") else {
            throw MLLabelGeneratorError.modelNotFound
        }
        let compiledURL = try MLModel.compileModel(at: url)
        let mlModel = try MLModel(contentsOf: compiledURL)
        vnModel = try VNCoreMLModel(for: mlModel)
    }

    /// Classifies a UIImage and returns the top label suggestion.
    public func suggestLabel(for image: UIImage) async throws -> MLLabelSuggestion {
        guard let cg = image.cgImage else { throw MLLabelGeneratorError.imageConversionFailed }

        let request = VNCoreMLRequest(model: try requireModel()) { request, _ in }
        request.imageCropAndScaleOption = .centerCrop

        let handler = VNImageRequestHandler(cgImage: cg, orientation: .up)
        try handler.perform([request])

        guard let results = request.results as? [VNClassificationObservation],
              let top = results.first else {
            throw MLLabelGeneratorError.requestFailed
        }
        return MLLabelSuggestion(label: top.identifier, confidence: top.confidence)
    }

    private func requireModel() throws -> VNCoreMLModel {
        guard let vnModel else { throw MLLabelGeneratorError.modelNotFound }
        return vnModel
    }
}
