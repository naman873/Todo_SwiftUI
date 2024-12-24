//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Naman Dhiman on 22/12/24.
//

import SwiftUI
import SwiftUISnackbar

@main
struct TodoAppApp: App {
    @StateObject private var localStorage = LocalStorage();
    var body: some Scene {
        WindowGroup {
            HomePage().environmentObject(localStorage).environmentObject(SnackbarStore())
        }
    }
}
