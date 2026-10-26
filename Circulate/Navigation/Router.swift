//
//  Router.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//

// Router.swift
import SwiftUI
import Observation

@Observable
final class Router {
    var path: [Route] = []
    var sheet: Sheet?

    func push(_ route: Route) { path.append(route) }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() { path.removeAll() }

    /// Replace everything above the root with one screen (avoids Signup -> Login -> Signup loops)
    func replaceStack(with route: Route) { path = [route] }

    func present(_ sheet: Sheet) { self.sheet = sheet }
}
