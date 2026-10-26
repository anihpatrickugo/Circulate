//
//  Route.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//



// Routes.swift
enum Route: Hashable {
    case signup
    case login
//    case forgotPassword
//    case verifyOTP(email: String)   // pass small values or IDs, not big models
}

enum Sheet: Identifiable {
    case settings
    case support
    var id: Self { self }
}
