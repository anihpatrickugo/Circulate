//
//  LoginView.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//


import SwiftUI

struct LoginView: View {
    @Environment(Router.self) private var router
    @Environment(SessionStore.self) private var session



    @State private var phone = ""
    @State private var selectedCountry = CountryOption(flag: "🇺🇸", code: "+1", name: "United States")
    
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @State private var faceId = false
    
    private let countries = [
            CountryOption(flag: "🇺🇸", code: "+1", name: "United States"),
            CountryOption(flag: "🇬🇧", code: "+44", name: "United Kingdom"),
            CountryOption(flag: "🇨🇦", code: "+1", name: "Canada"),
            CountryOption(flag: "🇳🇬", code: "+234", name: "Nigeria")
        ]

    private let brandBlue = Color(hex: "#1B28D9")
    private let mutedGray = Color(hex: "#8A8A8A")

    private var canSubmit: Bool {
        !phone.trimmingCharacters(in: .whitespaces).isEmpty &&  !isLoading
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

                Button{
                    
                }label: {
                    Text("Help").foregroundStyle(Color(hex: "#059669"))
                }
                
            }

            ScrollView {
                VStack(alignment: .leading,spacing: 16) {
                    VStack(alignment: .leading) {
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                            .foregroundStyle(Color(hex: "#059669"))
                            .padding(8)
                            .background(Color(hex: " #90EE90"), in: RoundedRectangle(cornerRadius: 12))
                            
                        
                        Text("Circulate")
                            .font(.system(size: 28, weight: .semibold))
                        Text("Welcome to the peer-to-peer sharing economy.")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                        
                        
                        // apple button
                        Button(action: {

                        }) {
                            HStack {
                                Image(systemName: "apple.logo").foregroundColor(.white)
                                Text("Continue with Apple")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.white)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                .black,
                                in: RoundedRectangle(cornerRadius: 12)
                            )
                        }
                        .buttonStyle(.plain)
                        
                        
                        // google button
                        Button(action: {

                        }) {
                            HStack {
                                Image(systemName: "globe").foregroundColor(.black)
                                Text("Continue with Google")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.black)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                .white,
                                in: RoundedRectangle(cornerRadius: 12)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    
                    
                    HStack(alignment: .center){
                        Spacer()
                        Text("or continue with phone / email").foregroundStyle(.gray).textCase(.uppercase).font(.system(size: 14))
                        Spacer()
                    }
                    
                    IconTextField(
                        label: "PHONE NUMBER",
                        placeholder: "(555) 019-2834",
                        text: $phone,
                        selectedCountry: $selectedCountry,
                        availableCountries: countries,
                        keyboard: .phonePad
                    )

                    

                    if let errorMessage {
                        Text(errorMessage)
                            .font(.system(size: 13))
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    // Face id
                    HStack (alignment: .center){
                        HStack(alignment: .center){
                            
                            Image(systemName: "face.smiling")
                                .foregroundStyle(Color(hex: "#059669"))
                                .padding(8)
                                .background(Color(hex: "#d5d0e8"), in: RoundedRectangle(cornerRadius: 12))
                            
                            VStack(alignment: .leading){
                                Text("Face ID Fast Booking").font(.system(size: 16, weight: .semibold))
                                Text("Instant checkout & unlock").foregroundStyle(.gray).font(.system(size: 12))
                            }
                        }
                        Spacer()
                        Toggle("Enable Feature", isOn: $faceId).labelsHidden()
                    }.padding(14).background(.white).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 0.3))

                    
                    
                    Button(action: {
                        Task { await login() }
                    }) {
                        HStack {
                            Text("Continue")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Image(systemName: "arrow.right").foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            Color(hex: "#059669"),
                            in: RoundedRectangle(cornerRadius: 16)
                        )
                    }
                    .buttonStyle(.plain)
                    
                    
                    
                    // community shield
                    HStack (alignment: .top){
                        
                        Image(systemName: "checkmark.shield.fill")
                            .foregroundStyle(Color(hex: "#059669"))
                            .padding(8)
                            .background(Color(hex: " #90EE90"), in: RoundedRectangle(cornerRadius: 12))
                        
                        
                        VStack(alignment: .leading){
                            HStack(alignment: .bottom){
                                Text("Verified Community Shield").fontWeight(.semibold).font(.system(size: 16))
                                
                                Text(" Stripe ID ").font(.system(size: 14)).foregroundStyle(.indigo).background(Color(hex: "#ddcffb"))
                            }
                           
                            
                            Text("Every lender & borrower undergoes biometric identity verification. Peer equipment is backed by our  [$2,000 guarantee](https://example.com) and secure escrow holds.").font(.system(size: 14)).foregroundStyle(.gray).tint(.black)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }.padding(14).background(Color(hex: "#f2faf4")).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 0.3))
                    
                   Spacer()

                    // Terms and privacy
                    Text("By continuing, you acknowledge you have read and agreed to our [Terms of Service](https://example.com/terms) and [Privacy Policy](https://example.com/privacy).").multilineTextAlignment(.center).foregroundColor(.gray).tint(.black).font(.system(size: 14))
                }
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Actions

    private func login() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        do {
            // Replace with your real API call, e.g. try await AuthService.shared.login(email:password:)
            try await Task.sleep(for: .seconds(1))

            session.signIn()   // root view swaps to MainTabView
        } catch {
            errorMessage = "Login failed. Check your details and try again."
        }
    }
}


#Preview {
    NavigationStack {
        LoginView()
    }
    .environment(Router())
    .environment(SessionStore())
}

#Preview("Full auth flow") {
    AuthFlow()
        .environment(SessionStore())
}
