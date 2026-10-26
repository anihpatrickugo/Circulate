//
//  CirculateApp.swift
//  Circulate
//
//  Created by Anihpatrickugo on 19/10/2026.
//

import SwiftUI

@main
struct CirculateApp: App {
    @State private var session = SessionStore()

    var body: some Scene {
        WindowGroup {
            Group {
                if session.isLoggedIn {
//                    MainTabView()
                } else {
                    AuthFlow()
                }
            }
            .environment(session)
        }
    }
}
