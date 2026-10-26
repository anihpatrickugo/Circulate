//
//  IconTextField.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//

import SwiftUI

// A simple model for country options
struct CountryOption: Identifiable, Hashable {
    let id = UUID()
    let flag: String
    let code: String
    let name: String
}

struct IconTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    
    // Bindable country selection
    @Binding var selectedCountry: CountryOption
    let availableCountries: [CountryOption]
    
    var icon: String? = nil
    var isSecure: Bool = false
    var keyboard: UIKeyboardType = .default

    @State private var isRevealed = false
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // 1. Top Small Label
            Text(label)
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(Color(hex: "#6B7280"))
                .tracking(0.5)

            // 2. Input Row
            HStack(spacing: 8) {
                // Check if countries are available to render a picker menu
                if !availableCountries.isEmpty {
                    Menu {
                        ForEach(availableCountries, id: \.self) { country in
                            Button {
                                selectedCountry = country
                            } label: {
                                Text("\(country.flag)  \(country.name)")

                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(selectedCountry.flag)
                                .font(.system(size: 16))
                            
                            Text(selectedCountry.code)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(Color(hex: "#8A8A8A"))
                        }
                    }
                    
                    // Vertical Separator Line
                    Rectangle()
                        .fill(Color(hex: "#E5E7EB"))
                        .frame(width: 1, height: 20)
                        .padding(.horizontal, 4)
                        
                } else if let icon = icon {
                    Image(systemName: icon)
                        .foregroundStyle(Color(hex: "#8A8A8A"))
                }

                // Main Text Input Field
                Group {
                    if isSecure && !isRevealed {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                            .keyboardType(keyboard)
                    }
                }
                .font(.system(size: 16))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($isFocused)

                // Password toggle
                if isSecure {
                    Button {
                        isRevealed.toggle()
                    } label: {
                        Image(systemName: isRevealed ? "eye" : "eye.slash")
                            .foregroundStyle(Color(hex: "#8A8A8A"))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(isFocused ? Color(hex: "#059669") : Color(hex: "#E5E7EB"), lineWidth: isFocused ? 1.5 : 1)
        }
        .animation(.easeInOut(duration: 0.15), value: isFocused)
    }
}
