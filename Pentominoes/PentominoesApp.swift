//
//  PentominoesApp.swift
//  Pentominoes
//
//  Created by Tej Patel on 22/09/24.
//

import SwiftUI

@main
struct PentominoesApp: App {
    @State var manager = GameManager()
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(manager)
        }
    }
}
