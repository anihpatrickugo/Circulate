//
//  SignupView.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//

import SwiftUI

struct SignupView: View {
    @Environment(Router.self) private var router
    @Environment(SessionStore.self) private var session

    @State private var fullName = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var selectedCountry = CountryOption(flag: "🇺🇸", code: "+1", name: "United States")
    
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    private let countries = [
        CountryOption(flag: "🇺🇸", code: "+1", name: "United States"),
        CountryOption(flag: "🇬🇧", code: "+44", name: "United Kingdom"),
        CountryOption(flag: "🇨🇦", code: "+1", name: "Canada"),
        CountryOption(flag: "🇳🇬", code: "+234", name: "Nigeria")
    ]

    private var canSubmit: Bool {
        !fullName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !phone.trimmingCharacters(in: .whitespaces).isEmpty &&
        !password.trimmingCharacters(in: .whitespaces).isEmpty &&
        !isLoading
    }

    var body: some View {
        VStack(spacing: 16) {
            // Custom header
            HStack {
                Button {
                    router.pop()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                        .frame(width: 44, height: 44)
                }

                Spacer()

                Text("SECURE 256-BIT")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color(hex: "#059669"))

                Spacer()

                Button {
                    // Help action
                } label: {
                    Text("Help")
                        .foregroundStyle(Color(hex: "#059669"))
                }
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Top App Identity Section
                    VStack(alignment: .leading, spacing: 8) {
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                            .font(.system(size: 20))
                            .foregroundStyle(Color(hex: "#059669"))
                            .padding(10)
                            .background(Color(hex: "#90EE90").opacity(0.4), in: RoundedRectangle(cornerRadius: 12))
                           
                        Text("Create Account")
                            .font(.system(size: 28, weight: .semibold))
                        
                        Text("Join the peer-to-peer sharing economy today.")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                    }

                    // Social Signups
                    VStack(spacing: 12) {
                        // Apple Button
                        Button(action: {
                            // Handle Apple Sign Up
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "apple.logo")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                Text("Continue with Apple")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(.black, in: RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                       
                        // Google Button
                        Button(action: {
                            // Handle Google Sign Up
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "globe")
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                Text("Continue with Google")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(.white, in: RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(hex: "#E5E7EB"), lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    
                    // Divider
                    HStack {
                        VStack { Divider() }
                        Text("or register with details")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.gray)
                            .textCase(.uppercase)
                            .padding(.horizontal, 8)
                        VStack { Divider() }
                    }
                    .padding(.vertical, 4)

                    // Full Name Field (Using standard icon layout)
                    IconTextField(
                        label: "FULL NAME",
                        placeholder: "e.g. John Doe",
                        text: $fullName,
                        selectedCountry: .constant(CountryOption(flag: "", code: "", name: "")),
                        availableCountries: [],
                        icon: "person",
                        keyboard: .default
                    )
                   
                    // Phone Number Input Field
                    IconTextField(
                        label: "PHONE NUMBER",
                        placeholder: "(555) 019-2834",
                        text: $phone,
                        selectedCountry: $selectedCountry,
                        availableCountries: countries,
                        keyboard: .phonePad
                    )

                    // Password Field
                    IconTextField(
                        label: "PASSWORD",
                        placeholder: "Create a secure password",
                        text: $password,
                        selectedCountry: .constant(CountryOption(flag: "", code: "", name: "")),
                        availableCountries: [],
                        icon: "lock",
                        isSecure: true,
                        keyboard: .default
                    )

                    if let errorMessage {
                        Text(errorMessage)
                            .font(.system(size: 13))
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    // Continue Button
                    Button(action: {
                        Task { await signup() }
                    }) {
                        HStack(spacing: 8) {
                            Text("Agree & Register")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                           
                            Image(systemName: "arrow.right")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            canSubmit ? Color(hex: "#059669") : Color(hex: "#059669").opacity(0.5),
                            in: RoundedRectangle(cornerRadius: 12)
                        )
                    }
                    .buttonStyle(.plain)
                    .disabled(!canSubmit)
                   
                    // Community Shield Info Box
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.shield.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(Color(hex: "#059669"))
                            .padding(10)
                            .background(Color(hex: "#90EE90").opacity(0.4), in: RoundedRectangle(cornerRadius: 12))
                       
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(alignment: .center, spacing: 6) {
                                Text("Verified Community Shield")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 15))
                               
                                Text(" Stripe ID ")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundStyle(.indigo)
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 6)
                                    .background(Color(hex: "#ddcffb"), in: RoundedRectangle(cornerRadius: 4))
                            }
                           
                            Text("Every lender & borrower undergoes biometric identity verification. Peer equipment is backed by our [$2,000 guarantee](https://example.com) and secure escrow holds.")
                                .font(.system(size: 13))
                                .foregroundStyle(.gray)
                                .tint(.black)
                        }
                    }
                    .padding(14)
                    .background(Color(hex: "#f2faf4"))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "#059669").opacity(0.2), lineWidth: 1))
                   
                    // Terms and Privacy
                    Text("By registering, you acknowledge you have read and agreed to our [Terms of Service](https://example.com/terms) and [Privacy Policy](https://example.com/privacy).")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .tint(.black)
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity)
                        .padding(.top, 4)
                }
                .padding(.bottom, 24)
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.interactively)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Actions

    private func signup() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        do {
            try await Task.sleep(for: .seconds(1))
            session.signIn()   // root view swaps to MainTabView
        } catch {
            errorMessage = "Registration failed. Please try again."
        }
    }
}


#Preview {
    NavigationStack {
        SignupView()
    }
    .environment(Router())
    .environment(SessionStore())
}


#Preview("Full auth flow") {
    AuthFlow()
        .environment(SessionStore())
}
