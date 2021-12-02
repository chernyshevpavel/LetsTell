//
//  MainTabBar.swift
//  LetsTell
//
//  Created by Павел Чернышев on 26.03.2021.
//

import SwiftUI

struct MainTabBarView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appManager: ApplicationManager
    
    @State var selection = 0
    @State var feedView: FeedView
    @State var storiesView: StoriesView
    @State var profileView: ProfileView

    var body: some View {
        TabView(selection: $selection) {
            feedView.tabItem {
                Image("􀎟")
                    .renderingMode(.template)
                Text("Feed")
            }
            storiesView.tabItem {
                Image("􀙋")
                    .renderingMode(.template)
                Text("Stories")
            }
            profileView.tabItem {
                Image("􀉮")
                    .renderingMode(.template)
                Text("Profile")
            }
        }
    
        .accentColor(colorScheme == .dark ?
                        Color(customColor: .yellow) :
                        Color(customColor: .black))
        .onAppear(perform: {
            UITabBar.appearance().backgroundImage = UIImage()
            UITabBar.appearance().isTranslucent = true
            if self.colorScheme == .dark {
                UITabBar.appearance().backgroundColor = UIColor(Color(customColor: .black))
            } else {
                UITabBar.appearance().backgroundColor = UIColor(Color(customColor: .tabbarWhite))
            }

        })
    }
}

struct MainTabBarPreviews: PreviewProvider {
    static func getFeedVC() -> FeedViewController {
        let feedVC = FeedViewController()
        feedVC.stories = ModelData().feedResponse.body
        return feedVC
    }
    
    static var previews: some View {
        
        ForEach(["iPhone 11"], id: \.self) { _ in
            MainTabBarView(
                feedView: FeedView(feedViewController: getFeedVC()),
                storiesView: StoriesView(),
                profileView: ProfileView(profileViewController: ProfileViewController()))
                .colorScheme(.dark)
                .environmentObject(UserAuthManager())
            MainTabBarView(
                feedView: FeedView(feedViewController: getFeedVC()),
                storiesView: StoriesView(),
                profileView: ProfileView(profileViewController: ProfileViewController()))
                .colorScheme(.light)
                .environmentObject(UserAuthManager())
        }
        
    }
}
