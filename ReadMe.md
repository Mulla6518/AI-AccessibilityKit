
# AI-AccessibilityKit

### AI-Powered Accessibility Toolkit for iOS Apps

**AI-AccessibilityKit** is a Swift package designed to make iOS apps more inclusive by leveraging **Core ML**, **Vision**, and **SwiftUI**. It automates accessibility audits and enhancements, helping developers deliver **WCAG-compliant**, **VoiceOver-friendly**, and **Dynamic Type-ready** experiences.

---

## ✅ Features

- **Auto VoiceOver Labels**  
  Automatically generate accessibility labels for images and icons using:
  - Core ML image classification
  - Vision OCR for text detection

- **Dynamic Font Scaling**  
  Apply adaptive font sizes for better readability across all Dynamic Type settings.

- **Color Contrast Audit**  
  Real-time WCAG 2.1 contrast ratio checks with visual badges in previews.

- **Touch Target Audit**  
  Highlights UI elements smaller than Apple’s recommended 44pt minimum.

- **Real-Time Accessibility Overlay**  
  Adds a 44pt grid and audit badges in Xcode Previews for proactive design checks.

---

## 📦 Installation

Add **AI-AccessibilityKit** to your project using **Swift Package Manager**:

1. In Xcode, go to **File → Add Packages…**
2. Enter the repository URL:
``` 
https://github.com/Mulla6518/AI-AccessibilityKit.git
```
3. Select **Add Package** and link it to your app target.

---

## 🛠 Usage Examples

### 1. Auto VoiceOver Labels
```swift
import SwiftUI
import AIAccessibilityKit

Image(systemName: "leaf.fill")
 .autoVoiceOverLabel() // AI-generated label via Core ML + Vision
 ```

 ### 2. Dynamic Font Scaling
```swift
Text("Eco Rewards")
    .dynamicFont(.title3) // Automatically scales for accessibility sizes
```

 ### 3. Color Contrast Audit
```swift
VStack {
    Text("Accessible Text")
}
.auditContrast(foreground: .primary, background: .white)
```

 ### 4. Touch Target Audit
```swift
Button("Continue") { }
    .auditTouchTarget() // Highlights if < 44pt
```

 ### 5. Real-Time Audit Overlay
```swift
#Preview {
    AccessibleCard()
        .modifier(AccessibilityAuditOverlay(showGrid: true))
}
```

 ### Example Component
```swift
struct AccessibleCard: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "leaf.fill")
                .autoVoiceOverLabel()
                .auditTouchTarget()

            Text("Eco Rewards")
                .dynamicFont(.title3)

            Text("Earn points for sustainable purchases.")
                .dynamicFont(.body)

            Button("Continue") { }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .autoVoiceOverLabel()
                .auditTouchTarget()
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .auditContrast(foreground: .primary, background: .white)
        .modifier(AccessibilityAuditOverlay(showGrid: true))
    }
}
```

✅ Requirements
* iOS 18+
* Xcode 16+
* Core ML model (e.g., ImageClassifier.mlmodel) for image labeling

📖 How It Works
* Core ML + Vision: Snapshots SwiftUI views, runs OCR and image classification to suggest labels.
* SwiftUI Modifiers: Apply accessibility audits without changing your existing layout.
* Previews Integration: Visualize audits in real-time during development.

🔍 Roadmap
* ✅ Auto VoiceOver labels
* ✅ WCAG contrast audits
* ✅ Touch target checks
* 🔜 Localization-aware AI labels
* 🔜 Snapshot-based accessibility reports for CI/CD

🤝 Contributing
Contributions are welcome!
* Fork the repo
* Create a feature branch
* Submit a pull request

📄 License
MIT License. See LICENSE for details.