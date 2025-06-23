import SwiftUI

extension Color {
    enum Palette {
        static let gray66 = Color(hex: "#666666")
        static let gray33 = Color(hex: "#333333")
        static let lightGrayF8 = Color(hex: "#F8F8F8")
    }
}

private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        if scanner.scanHexInt64(&rgb) {
            let r = Double((rgb & 0xFF0000) >> 16) / 255.0
            let g = Double((rgb & 0x00FF00) >> 8) / 255.0
            let b = Double(rgb & 0x0000FF) / 255.0

            self.init(red: r, green: g, blue: b)
        } else {
            self = .black // fallback
        }
    }
}

