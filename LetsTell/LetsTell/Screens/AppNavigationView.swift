//
//  NavigationView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 30.03.2021.
//

import SwiftUI

struct AppNavigationView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appManager: ApplicationManager
    @EnvironmentObject var authController: AuthViewController

    @StateObject var loadingAppViewController = LoadingAppViewController()
    @StateObject var feedViewController = FeedViewController()
    @StateObject var profileController = ProfileViewController()
    
    var body: some View {
        if loadingAppViewController.isLoaded {
            if authController.userAuth?.isLoggedin ?? false {
                MainTabBarView(
                    feedView: FeedView(feedViewController: feedViewController),
                    storiesView: StoriesView(),
                    profileView: ProfileView(profileViewController: profileController)
                )
                    .onAppear {
                        feedViewController.setup(container: appManager)
                        profileController.setup(container: appManager)
                        // storiesController.setup(container: appManager)
                    }
                    .environmentObject(appManager)
                    .environmentObject(authController)
            } else {
                AuthView(authViewController: authController)
            }
        } else {
            LoadingAppView(controller: loadingAppViewController)
                .onAppear(perform: {
                    loadingAppViewController.setup(container: appManager)
                    loadingAppViewController.checkToken()
                })
        }
    }
    
    func isUserLoggedIn() -> Bool {
        let userAuth: UserAuth = appManager.getObject()
        return userAuth.isLoggedin
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigationView()
    }
}
