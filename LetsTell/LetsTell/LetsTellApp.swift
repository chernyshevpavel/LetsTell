//
//  LetsTellApp.swift
//  LetsTell
//
//  Created by Павел Чернышев on 11.03.2021.
//

import SwiftUI
import UIKit

let apiUrl: URL = {
    let urlStr = "https://lets-tell.herokuapp.com/api/v1"
    guard let url = URL(string: urlStr) else {
        fatalError("can not cast string: \(urlStr) to URL")
    }
    return url
}()

@main
struct LetsTellApp: App {
    @StateObject var appManager = ApplicationManager()
    @StateObject var authController = AuthViewController()

    var body: some Scene {
        WindowGroup {
            AppNavigationView()
                .onAppear(perform: {
                    appManager.container.register(AuthViewController.self) { _ in
                        self.authController
                    }
                    authController.setup(container: appManager)
                })
                .environmentObject(appManager)
                .environmentObject(authController)
        }
    }
}
