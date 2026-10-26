//
//  AuthFlow.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//

// AuthFlow.swift


import SwiftUI


struct AuthFlow: View {
    @State private var router = Router()

    var body: some View {
        @Bindable var router = router

        NavigationStack(path: $router.path) {
            WelcomeView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .signup:                 SignupView()
                    case .login:                  LoginView()
//                    case .forgotPassword:         ForgotPasswordView()
//                    case .verifyOTP(let email):   VerifyOTPView(email: email)
                    }
                }
        }
        .sheet(item: $router.sheet) { sheet in
//            switch sheet {
//            case .settings: SettingsView()
//            case .support:  SupportView()
//            }
        }
        .environment(router)
    }
}
