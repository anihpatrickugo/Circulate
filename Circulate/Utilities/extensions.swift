//
//  extensions.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//



import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let value = UInt64(hex, radix: 16) ?? 0

        self.init(
            .sRGB,
            red: Double((value >> 16) & 0xFF) / 255,
            green: Double((value >> 8) & 0xFF) / 255,
            blue: Double(value & 0xFF) / 255,
            opacity: 1
        )
    }
}


extension String {
    func link(_ url: String) -> AttributedString {
        var attributedString = AttributedString(self)
        attributedString.link = URL(string: url)
        attributedString.foregroundColor = UIColor(
            Color(hex: "#1B28D9")
        )
        return attributedString
    }
}
