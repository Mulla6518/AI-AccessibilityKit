//
//  DynamicFontScaleModifier.swift
//  AI-AccessibilityKit
//
//  Created by Farooq Mulla on 1/8/26.
//

import SwiftUI

public struct DynamicFontScaleModifier: ViewModifier {
    let textStyle: Font.TextStyle

    public init(_ textStyle: Font.TextStyle = .body) {
        self.textStyle = textStyle
    }

    public func body(content: Content) -> some View {
        content
            .font(.system(textStyle, design: .rounded))
            .minimumScaleFactor(0.75)
            .dynamicTypeSize(.xSmall ... .accessibility5) // allow full range
    }
}

public extension View {
    func dynamicFont(_ style: Font.TextStyle = .body) -> some View {
        modifier(DynamicFontScaleModifier(style))
    }
}
