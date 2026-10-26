//
//  SessionStore.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//

import SwiftUI
import Observation


// SessionStore.swift
@Observable
final class SessionStore {
    var isLoggedIn = false
    func signIn() { isLoggedIn = true }
    func signOut() { isLoggedIn = false }
}


