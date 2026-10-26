//
//  Signup.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//

import SwiftUI


struct SignupView: View {
    @Environment(Router.self) private var router
    @Environment(SessionStore.self) private var session

    // ...your @State fields...

    var body: some View {
        VStack {
            // Back button
            Button { router.pop() } label: { /* chevron */ }

            // Continue button
            Button {
                // after API success:
//                router.push(.verifyOTP(email: email))
            } label: { Text("Continue") }

            // "Already have an account?" link
            Button("Log In") { router.replaceStack(with: .login) }
        }
        .navigationBarBackButtonHidden(true)
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
